package com.company.project.controller.sys;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.company.project.entity.sys.SysContentEntity;
import com.company.project.service.sys.SysContentService;
import com.company.project.utilities.aop.annotation.DataScope;
import com.company.project.utilities.utils.DataResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;


/**
 * 文章管理
 *
 * @author wenbin
 * @version V1.0
 * @date 2020年3月18日
 */
@Api(tags = "文章管理")
@RestController
@RequestMapping("/sysContent")
public class SysContentController {
    @Resource
    private SysContentService sysContentService;


    @ApiOperation(value = "新增")
    @PostMapping("/add")
    @PreAuthorize("hasAuthority('sysContent:add')")
    public DataResult add(@RequestBody SysContentEntity sysContent) {
        sysContentService.save(sysContent);
        return DataResult.success();
    }

    @ApiOperation(value = "删除")
    @DeleteMapping("/delete")
    @PreAuthorize("hasAuthority('sysContent:delete')")
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids) {
        sysContentService.removeByIds(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "更新")
    @PutMapping("/update")
    @PreAuthorize("hasAuthority('sysContent:update')")
    public DataResult update(@RequestBody SysContentEntity sysContent) {
        sysContentService.updateById(sysContent);
        return DataResult.success();
    }

    @ApiOperation(value = "查询分页数据")
    @PostMapping("/listByPage")
    @PreAuthorize("hasAuthority('sysContent:list')")
    @DataScope
    public DataResult findListByPage(@RequestBody SysContentEntity sysContent) {
        LambdaQueryWrapper<SysContentEntity> queryWrapper = Wrappers.lambdaQuery();
        //查询条件示例
        if (!StringUtils.isEmpty(sysContent.getTitle())) {
            queryWrapper.like(SysContentEntity::getTitle, sysContent.getTitle());
        }
        //数据权限示例， 需手动添加此条件 begin
        if (!CollectionUtils.isEmpty(sysContent.getCreateIds())) {
            queryWrapper.in(SysContentEntity::getCreateId, sysContent.getCreateIds());
        }
        //数据权限示例， 需手动添加此条件 end

        IPage<SysContentEntity> iPage = sysContentService.page(sysContent.getQueryPage(), queryWrapper);
        return DataResult.success(iPage);
    }
}
