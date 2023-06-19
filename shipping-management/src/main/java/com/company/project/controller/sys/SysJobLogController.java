package com.company.project.controller.sys;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.company.project.entity.sys.SysJobLogEntity;
import com.company.project.service.sys.SysJobLogService;
import com.company.project.utilities.aop.annotation.LogAnnotation;
import com.company.project.utilities.utils.DataResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;


/**
 * 定时任务日志
 *
 * @author wenbin
 * @version V1.0
 * @date 2020年3月18日
 */
@Api(tags = "定时任务日志")
@RestController
@RequestMapping("/sysJobLog")
public class SysJobLogController {
    @Resource
    private SysJobLogService sysJobLogService;

    @ApiOperation(value = "查询分页数据")
    @PostMapping("/listByPage")
    @PreAuthorize("hasAuthority('sysJob:list')")
    public DataResult findListByPage(@RequestBody SysJobLogEntity sysJobLog) {
        LambdaQueryWrapper<SysJobLogEntity> queryWrapper = Wrappers.lambdaQuery();
        //查询条件示例
        if (!StringUtils.isEmpty(sysJobLog.getJobId())) {
            queryWrapper.like(SysJobLogEntity::getJobId, sysJobLog.getJobId());
        }
        queryWrapper.orderByDesc(SysJobLogEntity::getCreateTime);
        IPage<SysJobLogEntity> iPage = sysJobLogService.page(sysJobLog.getQueryPage(), queryWrapper);
        return DataResult.success(iPage);
    }

    @ApiOperation(value = "清空定时任务日志")
    @DeleteMapping("/delete")
    @PreAuthorize("hasAuthority('sysJob:delete')")
    @LogAnnotation(title = "清空")
    public DataResult delete() {
        sysJobLogService.remove(Wrappers.emptyWrapper());
        return DataResult.success();
    }

}