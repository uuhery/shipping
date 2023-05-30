package com.company.project.common.jwt;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.company.project.entity.sys.SysUser;
import com.company.project.service.sys.MyUserDetailsService;
import com.company.project.service.sys.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @Description: JWT登录授权过滤器
 * @Author: zlf
 * @Date: 2021/3/30
 */
@Component
@Slf4j
public class JwtAuthenticationTokenFilter extends OncePerRequestFilter {

    //@Autowired
    //private UserDetailsService userDetailsService;
    @Autowired
    private JwtTokenUtil jwtTokenUtil;
    @Value("${jwt.tokenHeader}")
    private String tokenHeader;
    @Value("${jwt.tokenHead}")
    private String tokenHead;

    @Autowired
    private MyUserDetailsService userDetailsService;

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain chain) throws ServletException, IOException {
        if (request.getMethod().equals("POST")) { // 检查请求是否为POST方法
            String authHeader = request.getHeader(this.tokenHeader);
            if (authHeader != null && authHeader.startsWith(this.tokenHead)) {
                String authToken = authHeader.substring(this.tokenHead.length()); // The part after "Bearer "
                String username = jwtTokenUtil.getUserNameFromToken(authToken);
                log.info("checking username: {}", username);
                if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                    UserDetails userDetails = userDetailsService.loadUserByUsername(username);
                    if (jwtTokenUtil.validateToken(authToken, userDetails)) {
                        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetails, new BCryptPasswordEncoder().encode("123456"), userDetails.getAuthorities());
                        authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                        log.info("authenticated user: {}", username);
                        SecurityContextHolder.getContext().setAuthentication(authentication);
                    }
                }
            }
        }
        chain.doFilter(request, response);
    }

//    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
//        List<GrantedAuthority> authorityList = new ArrayList<>();
//        /* 此处查询数据库得到角色权限列表，这里可以用Redis缓存以增加查询速度 */
//        authorityList.add(new SimpleGrantedAuthority("ROLE_USER"));  // 角色 需要以 ROLE_ 开头
//        return new org.springframework.security.core.userdetails.User(username,  "123456", true, true,
//                true, true, authorityList);
//    }
}
