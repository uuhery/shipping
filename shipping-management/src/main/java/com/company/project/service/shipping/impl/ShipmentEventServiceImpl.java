package com.company.project.service.shipping.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.company.project.entity.shipping.ShipmentEvent;
import com.company.project.mapper.shipping.ShipmentEventMapper;
import com.company.project.service.shipping.ShipmentEventService;
import org.springframework.stereotype.Service;


@Service("shipmentEventService")
public class ShipmentEventServiceImpl extends ServiceImpl<ShipmentEventMapper, ShipmentEvent> implements ShipmentEventService {


}