package com.company.project.controller.shipping;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.company.project.entity.shipping.Customer;
import com.company.project.service.shipment.CustomerService;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
//import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;
import com.baomidou.mybatisplus.core.metadata.IPage;
import java.util.List;
import com.company.project.common.utils.DataResult;


/**
 *
 *
 * @author wenbin
 * @email *****@mail.com
 * @date 2023-04-16 19:24:42
 */
@Controller
@RequestMapping("/")
public class CustomerController {
    @Autowired
    private CustomerService customerService;


    /**
     * 跳转到页面
     */
    @GetMapping("/index/customers")
    public String customers() {
        return "customers/list";
    }

    @ApiOperation(value = "新增")
    @PostMapping("customers/add")
    @PreAuthorize("hasAuthority('customers:add')")
    @ResponseBody
    public DataResult add(@RequestBody Customer customers){
        customerService.save(customers);
        return DataResult.success();
    }

    @ApiOperation(value = "删除")
    @DeleteMapping("customers/delete")
    @PreAuthorize("hasAuthority('customers:delete')")
    @ResponseBody
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids){
        customerService.removeByIds(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "更新")
    @PutMapping("customers/update")
    @PreAuthorize("hasAuthority('customers:update')")
    @ResponseBody
    public DataResult update(@RequestBody Customer customers){
        customerService.updateById(customers);
        return DataResult.success();
    }

    @ApiOperation(value = "查询分页数据")
    @PostMapping("customers/listByPage")
    @PreAuthorize("hasAuthority('customers:list')")
    @ResponseBody
    public DataResult findListByPage(@RequestBody Customer customers){
        LambdaQueryWrapper<Customer> queryWrapper = Wrappers.lambdaQuery();
        //查询条件示例
//        queryWrapper.eq(Customer::getCustomerId, customers.getCustomerId());
        queryWrapper.orderByAsc(Customer::getId);
        IPage<Customer> iPage = customerService.page(customers.getQueryPage(), queryWrapper);
        return DataResult.success(iPage);
    }

}
