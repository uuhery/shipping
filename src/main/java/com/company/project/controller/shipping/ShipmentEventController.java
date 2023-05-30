package com.company.project.controller.shipping;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.company.project.entity.shipping.ShipmentEvent;
import com.company.project.service.shipment.ShipmentEventService;
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
 * @date 2023-04-28 20:40:26
 */
@Controller
@RequestMapping("/")
public class ShipmentEventController {
    @Autowired
    private ShipmentEventService shipmentEventService;


    /**
    * 跳转到页面
    */
    @GetMapping("/index/shipmentEvent")
    public String shipmentEvent() {
        return "shipmentevent/list";
        }

    @ApiOperation(value = "新增")
    @PostMapping("shipmentEvent/add")
    @PreAuthorize("hasAuthority('shipmentEvent:add')")
    @ResponseBody
    public DataResult add(@RequestBody ShipmentEvent shipmentEvent){
        shipmentEventService.save(shipmentEvent);
        return DataResult.success();
    }

    @ApiOperation(value = "删除")
    @DeleteMapping("shipmentEvent/delete")
    @PreAuthorize("hasAuthority('shipmentEvent:delete')")
    @ResponseBody
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids){
        shipmentEventService.removeByIds(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "更新")
    @PutMapping("shipmentEvent/update")
    @PreAuthorize("hasAuthority('shipmentEvent:update')")
    @ResponseBody
    public DataResult update(@RequestBody ShipmentEvent shipmentEvent){
        shipmentEventService.updateById(shipmentEvent);
        return DataResult.success();
    }

    @ApiOperation(value = "查询分页数据")
    @PostMapping("shipmentEvent/listByPage")
    @PreAuthorize("hasAuthority('shipmentEvent:list')")
    @ResponseBody
    public DataResult findListByPage(@RequestBody ShipmentEvent shipmentEvent){
        LambdaQueryWrapper<ShipmentEvent> queryWrapper = Wrappers.lambdaQuery();
        //查询条件示例
//        queryWrapper.eq(ShipmentEvent::getId, shipmentEvent.getId());
        queryWrapper.orderByDesc(ShipmentEvent::getId);
        IPage<ShipmentEvent> iPage = shipmentEventService.page(shipmentEvent.getQueryPage(), queryWrapper);
        return DataResult.success(iPage);
    }

}
