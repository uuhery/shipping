package com.company.project.controller.sys;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.company.project.common.aop.annotation.LogAnnotation;
import com.company.project.common.utils.DataResult;
import com.company.project.entity.sys.SysLog;
import com.company.project.service.sys.LogService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
//import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 系统操作日志
 *
 * @author wenbin
 * @version V1.0
 * @date 2020年3月18日
 */
@RequestMapping("/sys")
@Api(tags = "系统模块-系统操作日志管理")
@RestController
public class SysLogController {
    @Resource
    private LogService logService;

    @PostMapping("/logs")
    @ApiOperation(value = "分页查询系统操作日志接口")
    @LogAnnotation(title = "系统操作日志管理", action = "分页查询系统操作日志")
    @PreAuthorize("hasAuthority('sys:log:list')")
    public DataResult pageInfo(@RequestBody SysLog vo) {
        LambdaQueryWrapper<SysLog> queryWrapper = Wrappers.lambdaQuery();
        if (!StringUtils.isEmpty(vo.getUsername())) {
            queryWrapper.like(SysLog::getUsername, vo.getUsername());
        }
        if (!StringUtils.isEmpty(vo.getOperation())) {
            queryWrapper.like(SysLog::getOperation, vo.getOperation());
        }
        if (!StringUtils.isEmpty(vo.getStartTime())) {
            queryWrapper.gt(SysLog::getCreateTime, vo.getStartTime());
        }
        if (!StringUtils.isEmpty(vo.getEndTime())) {
            queryWrapper.lt(SysLog::getCreateTime, vo.getEndTime());
        }
        queryWrapper.orderByDesc(SysLog::getCreateTime);
        return DataResult.success(logService.page(vo.getQueryPage(), queryWrapper));
    }

    @DeleteMapping("/logs")
    @ApiOperation(value = "删除日志接口")
    @LogAnnotation(title = "系统操作日志管理", action = "删除系统操作日志")
    @PreAuthorize("hasAuthority('sys:log:deleted')")
    public DataResult deleted(@RequestBody List<String> logIds) {
        logService.removeByIds(logIds);
        return DataResult.success();
    }
}
