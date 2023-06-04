package com.company.project.controller.shipping;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.company.project.DTO.ShipmentDTO;
import com.company.project.entity.shipping.Shipment;
import com.company.project.service.shipping.ShipmentService;
import com.company.project.utilities.kafka.KafkaMessageSender;
import com.company.project.utilities.utils.DataResult;
import com.fasterxml.jackson.core.JsonProcessingException;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.SneakyThrows;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;


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
    @Resource
    private ShipmentService shipmentService;

    @Resource
    private KafkaMessageSender kafkaMessageSender;

    /**
    * 跳转到页面
    */
    @GetMapping("/index/shipment")
    public String shipment() {
        return "shipment/list";
        }

    @SneakyThrows
    @ApiOperation(value = "新增")
    @PostMapping("shipment/add")
    @PreAuthorize("hasAuthority('shipment:add')")
    @ResponseBody
    public DataResult add(@RequestBody Shipment shipment) throws JsonProcessingException {
        Shipment savedShipment = shipmentService.saveShipment(shipment);
        // 发送消息给external-service服务
        try {
            kafkaMessageSender.sendMessage("carrier-billing-events", shipment);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return new DataResult(savedShipment);
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
