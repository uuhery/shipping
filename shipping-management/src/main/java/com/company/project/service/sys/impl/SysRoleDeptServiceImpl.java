package com.company.project.service.sys.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.company.project.entity.sys.SysRoleDeptEntity;
import com.company.project.service.sys.SysRoleDeptService;
import com.company.project.mapper.sys.SysRoleDeptMapper;
import org.springframework.stereotype.Service;


@Service("sysRoleDeptService")
public class SysRoleDeptServiceImpl extends ServiceImpl<SysRoleDeptMapper, SysRoleDeptEntity> implements SysRoleDeptService {


}