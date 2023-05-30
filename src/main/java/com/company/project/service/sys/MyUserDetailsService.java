package com.company.project.service.sys;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.company.project.entity.sys.CustomUserDetails;
import com.company.project.entity.sys.SysPermission;
import com.company.project.entity.sys.SysUser;
import com.company.project.mapper.sys.SysPermissionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Component
public class MyUserDetailsService implements UserDetailsService {
    @Autowired
    private UserService userService;
    @Resource
    private SysPermissionMapper permissionMapper;
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        SysUser user = userService.getUserByName(username);
        if (user == null) {
            throw new UsernameNotFoundException("用户不存在");
        }
        List<GrantedAuthority> authorityList = new ArrayList<>();
        /* 此处查询数据库得到角色权限列表，这里可以用Redis缓存以增加查询速度 */
        List<SysPermission> permissionList = permissionMapper.selectList(new QueryWrapper<SysPermission>().inSql("id",
                "SELECT p.id FROM sys_permission p\n" +
                "INNER JOIN sys_role_permission rp ON p.id = rp.permission_id\n" +
                "INNER JOIN sys_user_role ur ON rp.role_id = ur.role_id\n" +
                "WHERE ur.user_id = " + user.getId()));;
        user.setPermissionList(permissionList);
        for (SysPermission permission : user.getPermissionList()) {
            if(permission.getPerms()!=null) authorityList.add(new SimpleGrantedAuthority(permission.getPerms()));
        }
        return new CustomUserDetails(user, authorityList);
    }
}