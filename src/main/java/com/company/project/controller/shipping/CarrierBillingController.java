package com.company.project.controller.shipping;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.company.project.entity.shipping.CarrierBilling;
import com.company.project.entity.shipping.Shipment;
import com.company.project.service.shipment.CarrierBillingService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
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
 * @date 2023-04-26 17:58:48
 */
@Controller
@RequestMapping("/")
public class CarrierBillingController {
    @Autowired
    private CarrierBillingService carrierBillingService;


    /**
    * 跳转到页面
    */
    @GetMapping("/index/carrierBilling")
    public String carrierBilling() {
        return "carrierbilling/list";
        }

    @ApiOperation(value = "新增")
    @PostMapping("carrierBilling/add")
    @RequiresPermissions("carrierBilling:add")
    @ResponseBody
    public DataResult add(@RequestBody Shipment shipment){
        carrierBillingService.saveCarrierBilling(shipment);
        return DataResult.success();
    }

    @ApiOperation(value = "删除")
    @DeleteMapping("carrierBilling/delete")
    @RequiresPermissions("carrierBilling:delete")
    @ResponseBody
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids){
        carrierBillingService.removeByIds(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "更新")
    @PutMapping("carrierBilling/update")
    @RequiresPermissions("carrierBilling:update")
    @ResponseBody
    public DataResult update(@RequestBody CarrierBilling carrierBilling){
        carrierBillingService.updateById(carrierBilling);
        return DataResult.success();
    }

    @ApiOperation(value = "查询分页数据")
    @PostMapping("carrierBilling/listByPage")
    @RequiresPermissions("carrierBilling:list")
    @ResponseBody
    public DataResult findListByPage(@RequestBody CarrierBilling carrierBilling){
        LambdaQueryWrapper<CarrierBilling> queryWrapper = Wrappers.lambdaQuery();
        //查询条件示例
//        queryWrapper.eq(CarrierBilling::getId, carrierBilling.getId());
        queryWrapper.orderByAsc(CarrierBilling::getId);
        IPage<CarrierBilling> iPage = carrierBillingService.page(carrierBilling.getQueryPage(), queryWrapper);
        return DataResult.success(iPage);
    }

}
