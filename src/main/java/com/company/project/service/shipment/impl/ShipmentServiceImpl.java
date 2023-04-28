package com.company.project.service.shipment.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.company.project.entity.shipping.Carrier;
import com.company.project.entity.shipping.Customer;
import com.company.project.entity.shipping.Goods;
import com.company.project.entity.shipping.Shipment;
import com.company.project.mapper.shipping.CarrierMapper;
import com.company.project.mapper.shipping.CustomerMapper;
import com.company.project.mapper.shipping.GoodsMapper;
import com.company.project.mapper.shipping.ShipmentMapper;
import com.company.project.service.shipment.CarrierBillingService;
import com.company.project.service.shipment.ShipmentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;


@Service("shipmentService")
public class ShipmentServiceImpl extends ServiceImpl<ShipmentMapper, Shipment> implements ShipmentService {

    @Resource
    CarrierMapper carrierMapper;
    @Resource
    CustomerMapper customerMapper;
    @Resource
    GoodsMapper goodsMapper;
    @Resource
    ShipmentMapper shipmentMapper;

    public Shipment saveShipment(Shipment shipment) {
        LambdaQueryWrapper<Carrier> q1 = Wrappers.lambdaQuery();
        q1.eq(Carrier::getId, shipment.getCarrierId());
        Carrier carrier = carrierMapper.selectOne(q1);
        shipment.setOriginAddress(carrier.getAddress());
        shipment.setOriginCountry(carrier.getCountry());
        shipment.setOriginCity(carrier.getCity());
        shipment.setOriginPostalCode(carrier.getPostalCode());
        LambdaQueryWrapper<Customer> q2 = Wrappers.lambdaQuery();
        q2.eq(Customer::getId, shipment.getCustomerId());
        Customer customer = customerMapper.selectOne(q2);
        shipment.setDestinationAddress(customer.getAddress());
        shipment.setDestinationCountry(customer.getCountry());
        shipment.setDestinationCity(customer.getCity());
        shipment.setDestinationPostalCode(customer.getPostalCode());
        LambdaQueryWrapper<Goods> q3 = Wrappers.lambdaQuery();
        q3.eq(Goods::getId, shipment.getGoodsId());
        Goods goods = goodsMapper.selectOne(q3);
        shipment.setWeight(goods.getWeight().multiply(shipment.getNum()));
        shipment.setValue(goods.getPrice().multiply(shipment.getNum()));
        shipment.setOrderStatus(0);
        shipmentMapper.insert(shipment);
        return shipment;
    }
}