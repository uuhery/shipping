package com.company.project.controller.shipping;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.company.project.entity.shipping.CustomerBilling;
import com.company.project.entity.shipping.Shipment;
import com.company.project.service.shipment.CustomerBillingService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

import java.util.Date;
import java.util.List;
import com.company.project.common.utils.DataResult;



/**
 * 
 *
 * @author wenbin
 * @email *****@mail.com
 * @date 2023-04-28 13:24:41
 */
@Controller
@RequestMapping("/")
public class CustomerBillingController {
    @Autowired
    private CustomerBillingService customerBillingService;


    /**
    * 跳转到页面
    */
    @GetMapping("/index/customerBilling")
    public String customerBilling() {
        return "customerbilling/list";
        }

    @ApiOperation(value = "新增")
    @PostMapping("customerBilling/add")
    @RequiresPermissions("customerBilling:add")
    @ResponseBody
    public DataResult add(@RequestBody Shipment shipment){
        customerBillingService.saveCustomerBilling(shipment);
        return DataResult.success();
    }

    @ApiOperation(value = "删除")
    @DeleteMapping("customerBilling/delete")
    @RequiresPermissions("customerBilling:delete")
    @ResponseBody
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids){
        customerBillingService.removeByIds(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "更新")
    @PutMapping("customerBilling/update")
    @RequiresPermissions("customerBilling:update")
    @ResponseBody
    public DataResult update(@RequestBody CustomerBilling customerBilling){
        if(customerBilling.getPaymentMethod()!=null) {
            customerBilling.setState(1);
            customerBilling.setPaymentDate(new Date());
        }
        customerBillingService.updateById(customerBilling);
        return DataResult.success();
    }

    @ApiOperation(value = "查询分页数据")
    @PostMapping("customerBilling/listByPage")
    @RequiresPermissions("customerBilling:list")
    @ResponseBody
    public DataResult findListByPage(@RequestBody CustomerBilling customerBilling){
        LambdaQueryWrapper<CustomerBilling> queryWrapper = Wrappers.lambdaQuery();
        //查询条件示例
//        queryWrapper.eq(CustomerBilling::getId, customerBilling.getId());
        queryWrapper.orderByDesc(CustomerBilling::getId);
        IPage<CustomerBilling> iPage = customerBillingService.page(customerBilling.getQueryPage(), queryWrapper);
        return DataResult.success(iPage);
    }

}
