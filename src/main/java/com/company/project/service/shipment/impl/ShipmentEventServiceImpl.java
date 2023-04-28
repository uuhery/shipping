package com.company.project.service.shipment.impl;

import com.company.project.entity.shipping.ShipmentEvent;
import com.company.project.mapper.shipping.ShipmentEventMapper;
import com.company.project.service.shipment.ShipmentEventService;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;



@Service("shipmentEventService")
public class ShipmentEventServiceImpl extends ServiceImpl<ShipmentEventMapper, ShipmentEvent> implements ShipmentEventService {


}