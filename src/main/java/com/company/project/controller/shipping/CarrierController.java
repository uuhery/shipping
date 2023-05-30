package com.company.project.controller.shipping;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.company.project.entity.shipping.Carrier;
import com.company.project.service.shipment.CarrierService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import java.util.List;
import com.company.project.common.utils.DataResult;




/**
 *
 *
 * @author wenbin
 * @email *****@mail.com
 * @date 2023-04-16 18:26:37
 */
@Controller
@RequestMapping("/")
public class CarrierController {
    @Autowired
    private CarrierService carrierService;


    /**
     * 跳转到页面
     */
    @GetMapping("/index/carriers")
    public String carriers() {
        return "carriers/list";
    }

    @ApiOperation(value = "新增")
    @PostMapping("carriers/add")
    @PreAuthorize("hasAuthority('carriers:add')")
    @ResponseBody
    public DataResult add(@RequestBody Carrier carriers){
        carrierService.save(carriers);
        return DataResult.success();
    }

    @ApiOperation(value = "删除")
    @DeleteMapping("carriers/delete")
    @PreAuthorize("hasAuthority('carriers:delete')")
    @ResponseBody
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids){
        carrierService.removeByIds(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "更新")
    @PutMapping("carriers/update")
    @PreAuthorize("hasAuthority('carriers:update')")
    @ResponseBody
    public DataResult update(@RequestBody Carrier carriers){
        carrierService.updateById(carriers);
        return DataResult.success();
    }

    @ApiOperation(value = "查询分页数据")
    @PostMapping("carriers/listByPage")
    @PreAuthorize("hasAuthority('carriers:list')")
    @ResponseBody
    public DataResult findListByPage(@RequestBody Carrier carrier){
        LambdaQueryWrapper<Carrier> queryWrapper = Wrappers.lambdaQuery();
        //查询条件示例
        if(carrier.getId()!=null) queryWrapper.eq(Carrier::getId, carrier.getId());
        queryWrapper.orderByAsc(Carrier::getId);
        IPage<Carrier> iPage = carrierService.page(carrier.getQueryPage(), queryWrapper);
        return DataResult.success(iPage);
    }

}
