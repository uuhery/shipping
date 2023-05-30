package com.company.project.controller.shipping;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.company.project.entity.shipping.Shipment;
import com.company.project.service.shipment.ShipmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;
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
 * @date 2023-04-16 20:58:10
 */
@Controller
@RequestMapping("/")
public class ShipmentController {
    @Autowired
    private ShipmentService shipmentService;


    /**
    * 跳转到页面
    */
    @GetMapping("/index/shipment")
    public String shipment() {
        return "shipment/list";
        }

    @ApiOperation(value = "新增")
    @PostMapping("shipment/add")
    @PreAuthorize("hasAuthority('shipment:add')")
    @ResponseBody
    public DataResult add(@RequestBody Shipment shipment){
        return new DataResult(shipmentService.saveShipment(shipment));
    }

    @ApiOperation(value = "删除")
    @DeleteMapping("shipment/delete")
    @PreAuthorize("hasAuthority('shipment:delete')")
    @ResponseBody
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids){
        shipmentService.removeByIds(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "更新")
    @PutMapping("shipment/update")
    @PreAuthorize("hasAuthority('shipment:update')")
    @ResponseBody
    public DataResult update(@RequestBody Shipment shipment){
        if(shipment.getOrderStatus()==2) shipment.setDeliveryDate(new Date());
        shipmentService.updateById(shipment);
        return DataResult.success();
    }

    @ApiOperation(value = "查询分页数据")
    @PostMapping("shipment/listByPage")
    @PreAuthorize("hasAuthority('shipment:list')")
    @ResponseBody
    public DataResult findListByPage(@RequestBody Shipment shipment){
        LambdaQueryWrapper<Shipment> queryWrapper = Wrappers.lambdaQuery();
        //查询条件示例
//        queryWrapper.eq(Shipment::getOrderId, shipment.getOrderId());
        queryWrapper.orderByAsc(Shipment::getId);
        IPage<Shipment> iPage = shipmentService.page(shipment.getQueryPage(), queryWrapper);
        return DataResult.success(iPage);
    }

}
