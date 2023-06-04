package com.company.project.service.shipping.impl;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.company.project.entity.shipping.ShipmentRate;
import com.company.project.mapper.shipping.ShipmentRateMapper;
import com.company.project.service.shipping.ShipmentRateService;
import org.springframework.stereotype.Service;


@Service("shipmentRateService")
public class ShipmentRateServiceImpl extends ServiceImpl<ShipmentRateMapper, ShipmentRate> implements ShipmentRateService {


}