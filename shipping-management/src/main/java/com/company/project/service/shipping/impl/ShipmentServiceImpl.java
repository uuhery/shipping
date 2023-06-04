package com.company.project.service.shipping.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.company.project.DTO.ShipmentDTO;
import com.company.project.client.ExternalClient;
import com.company.project.entity.shipping.Customer;
import com.company.project.entity.shipping.Goods;
import com.company.project.entity.shipping.Shipment;
import com.company.project.mapper.shipping.GoodsMapper;
import com.company.project.mapper.shipping.ShipmentMapper;
import com.company.project.service.shipping.ShipmentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;


@Service("shipmentService")
public class ShipmentServiceImpl extends ServiceImpl<ShipmentMapper, Shipment> implements ShipmentService {
    @Resource
    GoodsMapper goodsMapper;
    @Resource
    ShipmentMapper shipmentMapper;
    @Resource
    ExternalClient externalClient;

    public Shipment saveShipment(Shipment shipment) {
        Customer send = externalClient.getCustomer(shipment.getSendId());
        shipment.setOriginAddress(send.getAddress());
        shipment.setOriginCountry(send.getCountry());
        shipment.setOriginCity(send.getCity());
        shipment.setOriginPostalCode(send.getPostalCode());
        Customer customer = externalClient.getCustomer(shipment.getCustomerId());
        shipment.setDestinationAddress(customer.getAddress());
        shipment.setDestinationCountry(customer.getCountry());
        shipment.setDestinationCity(customer.getCity());
        shipment.setDestinationPostalCode(customer.getPostalCode());
        LambdaQueryWrapper<Goods> q3 = Wrappers.lambdaQuery();
        q3.eq(Goods::getId, shipment.getGoodsId());
        Goods goods = goodsMapper.selectOne(q3);
        shipment.setWeight(goods.getWeight().multiply(shipment.getNum()));
        shipment.setValue(goods.getPrice().multiply(shipment.getNum()));
        shipment.setPickupDate(new Date());
        shipment.setOrderStatus(0);
        shipmentMapper.insert(shipment);
//        ShipmentDTO dto = convertToShipmentDTO(shipment);
        return shipment;
    }

    public List<Shipment> getId() {
        return shipmentMapper.selectList(new QueryWrapper<>());
    }

    public int shipmentCount() {
        return shipmentMapper.selectCount(new QueryWrapper<>());
    }
}