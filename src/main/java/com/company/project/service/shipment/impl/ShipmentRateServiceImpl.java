package com.company.project.service.shipment.impl;

import com.company.project.mapper.shipping.ShipmentRateMapper;
import com.company.project.service.shipment.ShipmentRateService;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.company.project.entity.shipping.ShipmentRate;




@Service("shipmentRateService")
public class ShipmentRateServiceImpl extends ServiceImpl<ShipmentRateMapper, ShipmentRate> implements ShipmentRateService {


}