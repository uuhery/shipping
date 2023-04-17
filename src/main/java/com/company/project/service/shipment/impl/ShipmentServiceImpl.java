package com.company.project.service.shipment.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.company.project.entity.shipping.Shipment;
import com.company.project.mapper.shipping.ShipmentMapper;
import com.company.project.service.shipment.ShipmentService;
import org.springframework.stereotype.Service;



@Service("shipmentService")
public class ShipmentServiceImpl extends ServiceImpl<ShipmentMapper, Shipment> implements ShipmentService {


}