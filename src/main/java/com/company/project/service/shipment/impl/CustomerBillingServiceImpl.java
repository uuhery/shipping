package com.company.project.service.shipment.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.toolkit.SqlHelper;
import com.company.project.entity.shipping.*;
import com.company.project.mapper.shipping.CustomerBillingMapper;
import com.company.project.mapper.shipping.ShipmentTypeMapper;
import com.company.project.service.shipment.CustomerBillingService;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;


@Service("customerBillingService")
public class CustomerBillingServiceImpl extends ServiceImpl<CustomerBillingMapper, CustomerBilling> implements CustomerBillingService {

    @Resource
    ShipmentTypeMapper shipmentTypeMapper;

    public boolean saveCustomerBilling(Shipment shipment) {
        CustomerBilling customerBilling = new CustomerBilling();
        customerBilling.setSendId(shipment.getSendId());
        customerBilling.setOrderId(shipment.getId());
        customerBilling.setCreateDate(new Date());
        LambdaQueryWrapper<ShipmentType> queryWrapper = Wrappers.lambdaQuery();
        queryWrapper.eq(ShipmentType::getId, shipment.getShipmentTypeId());
        ShipmentType shipmentType = shipmentTypeMapper.selectOne(queryWrapper);
        customerBilling.setPaymentAmount(shipmentType.getPrice().multiply(shipment.getWeight()));
        return SqlHelper.retBool(this.getBaseMapper().insert(customerBilling));
    }

    public Double customerCount() {
        LambdaQueryWrapper<CustomerBilling> queryWrapper = Wrappers.lambdaQuery();
        queryWrapper.eq(CustomerBilling::getState, 1);
        List<CustomerBilling> list = this.baseMapper.selectList(queryWrapper);
        Double total = 0.0;
        for(CustomerBilling c:list) {
            total += Double.parseDouble(c.getPaymentAmount().toString());
        }
        System.out.println(total);
        return Double.parseDouble(total.toString());
    }
}