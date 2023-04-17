package com.company.project.service.shipment.impl;

import com.company.project.entity.shipping.Carrier;
import com.company.project.mapper.shipping.CarrierMapper;
import com.company.project.service.shipment.CarrierService;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;




@Service("carrierService")
public class CarrierServiceImpl extends ServiceImpl<CarrierMapper, Carrier> implements CarrierService {
}