package com.company.project.controller.sys;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.company.project.common.utils.DataResult;
import com.company.project.entity.sys.SysDictDetailEntity;
import com.company.project.entity.sys.SysDictEntity;
import com.company.project.service.sys.SysDictDetailService;
import com.company.project.service.sys.SysDictService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;


/**
 * 字典管理
 *
 * @author wenbin
 * @version V1.0
 * @date 2020年3月18日
 */
@Api(tags = "字典管理")
@RestController
@RequestMapping("/sysDict")
public class SysDictController {
    @Resource
    private SysDictService sysDictService;
    @Resource
    private SysDictDetailService sysDictDetailService;


    @ApiOperation(value = "新增")
    @PostMapping("/add")
    @PreAuthorize("hasAuthority('sysDict:add')")
    public DataResult add(@RequestBody SysDictEntity sysDict) {
        if (StringUtils.isEmpty(sysDict.getName())) {
            return DataResult.fail("字典名称不能为空");
        }
        SysDictEntity q = sysDictService.getOne(Wrappers.<SysDictEntity>lambdaQuery().eq(SysDictEntity::getName, sysDict.getName()));
        if (q != null) {
            return DataResult.fail("字典名称已存在");
        }
        sysDictService.save(sysDict);
        return DataResult.success();
    }

    @ApiOperation(value = "删除")
    @DeleteMapping("/delete")
    @PreAuthorize("hasAuthority('sysDict:delete')")
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids) {
        sysDictService.removeByIds(ids);
        //删除detail
        sysDictDetailService.remove(Wrappers.<SysDictDetailEntity>lambdaQuery().in(SysDictDetailEntity::getDictId, ids));
        return DataResult.success();
    }

    @ApiOperation(value = "更新")
    @PutMapping("/update")
    @PreAuthorize("hasAuthority('sysDict:update')")
    public DataResult update(@RequestBody SysDictEntity sysDict) {
        if (StringUtils.isEmpty(sysDict.getName())) {
            return DataResult.fail("字典名称不能为空");
        }

        SysDictEntity q = sysDictService.getOne(Wrappers.<SysDictEntity>lambdaQuery().eq(SysDictEntity::getName, sysDict.getName()));
        if (q != null && !q.getId().equals(sysDict.getId())) {
            return DataResult.fail("字典名称已存在");
        }

        sysDictService.updateById(sysDict);
        return DataResult.success();
    }

    @ApiOperation(value = "查询分页数据")
    @PostMapping("/listByPage")
    @PreAuthorize("hasAuthority('sysDict:list')")
    public DataResult findListByPage(@RequestBody SysDictEntity sysDict) {
        LambdaQueryWrapper<SysDictEntity> queryWrapper = Wrappers.lambdaQuery();
        //查询条件示例
        if (!StringUtils.isEmpty(sysDict.getName())) {
            queryWrapper.like(SysDictEntity::getName, sysDict.getName());
            queryWrapper.or();
            queryWrapper.like(SysDictEntity::getRemark, sysDict.getName());
        }
        queryWrapper.orderByAsc(SysDictEntity::getName);
        IPage<SysDictEntity> iPage = sysDictService.page(sysDict.getQueryPage(), queryWrapper);
        return DataResult.success(iPage);
    }

}
