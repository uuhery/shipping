package com.company.project.controller.sys;

import com.company.project.common.aop.annotation.LogAnnotation;
import com.company.project.common.utils.DataResult;
import com.company.project.entity.sys.SysDept;
import com.company.project.service.sys.DeptService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
//import org.apache.shiro.authz.annotation.Logical;
//import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.List;

/**
 * 部门管理
 *
 * @author wenbin
 * @version V1.0
 * @date 2020年3月18日
 */
@RequestMapping("/sys")
@RestController
@Api(tags = "组织模块-机构管理")
public class DeptController {
    @Resource
    private DeptService deptService;

    @PostMapping("/dept")
    @ApiOperation(value = "新增组织接口")
    @LogAnnotation(title = "机构管理", action = "新增组织")
    @PreAuthorize("hasAuthority('sys:dept:add')")
    public DataResult addDept(@RequestBody @Valid SysDept vo) {
        deptService.addDept(vo);
        return DataResult.success();
    }

    @DeleteMapping("/dept/{id}")
    @ApiOperation(value = "删除组织接口")
    @LogAnnotation(title = "机构管理", action = "删除组织")
    @PreAuthorize("hasAuthority('sys:dept:deleted')")
    public DataResult deleted(@PathVariable("id") String id) {
        deptService.deleted(id);
        return DataResult.success();
    }

    @PutMapping("/dept")
    @ApiOperation(value = "更新组织信息接口")
    @LogAnnotation(title = "机构管理", action = "更新组织信息")
    @PreAuthorize("hasAuthority('sys:dept:update')")
    public DataResult updateDept(@RequestBody SysDept vo) {
        if (StringUtils.isEmpty(vo.getId())) {
            return DataResult.fail("id不能为空");
        }
        deptService.updateDept(vo);
        return DataResult.success();
    }

    @GetMapping("/dept/{id}")
    @ApiOperation(value = "查询组织详情接口")
    @LogAnnotation(title = "机构管理", action = "查询组织详情")
    @PreAuthorize("hasAuthority('sys:dept:detail')")
    public DataResult detailInfo(@PathVariable("id") String id) {
        return DataResult.success(deptService.getById(id));
    }

    @GetMapping("/dept/tree")
    @ApiOperation(value = "树型组织列表接口")
    @LogAnnotation(title = "机构管理", action = "树型组织列表")
    @PreAuthorize("hasAnyAuthority('sys:user:list', 'sys:user:update', 'sys:user:add', 'sys:dept:add', 'sys:dept:update')")
    public DataResult getTree(@RequestParam(required = false) String deptId) {
        return DataResult.success(deptService.deptTreeList(deptId, false));
    }

    @GetMapping("/depts")
    @ApiOperation(value = "获取机构列表接口")
    @LogAnnotation(title = "机构管理", action = "获取所有组织机构")
    @PreAuthorize("hasAuthority('sys:dept:list')")
    public DataResult getDeptAll() {
        List<SysDept> deptList = deptService.list();
        deptList.stream().forEach(entity -> {
            SysDept parentDept = deptService.getById(entity.getPid());
            if (parentDept != null) {
                entity.setPidName(parentDept.getName());
            }
        });
        return DataResult.success(deptList);
    }

}
