package com.company.project.service.shipment.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.company.project.entity.shipping.Shipment;
import com.company.project.entity.shipping.ShipmentType;
import com.company.project.mapper.shipping.CustomerBillingMapper;
import com.company.project.mapper.shipping.ShipmentTypeMapper;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import java.math.BigDecimal;

import static org.junit.Assert.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@SpringBootTest()
@RunWith(SpringRunner.class)
public class CustomerBillingServiceImplTest {
    @Autowired
    private CustomerBillingServiceImpl customerBillingService;
    @Mock
    private ShipmentTypeMapper shipmentTypeMapper;
    @Mock
    private CustomerBillingMapper customerBillingMapper;
    @Test
    public void testSaveCustomerBilling() {
        Shipment shipment = new Shipment();
        shipment.setId(13);
        shipment.setSendId(2);
        shipment.setShipmentTypeId(2);
        shipment.setWeight(BigDecimal.valueOf(20));
        ShipmentType shipmentType = new ShipmentType();
        shipmentType.setId(2);
        shipmentType.setPrice(BigDecimal.valueOf(16));
        when(shipmentTypeMapper.selectOne(new QueryWrapper<>())).thenReturn(shipmentType);
        when(customerBillingMapper.insert(any())).thenReturn(1);
        boolean result = customerBillingService.saveCustomerBilling(shipment);
        assertTrue(result);
    }

    @Test
    public void testCustomerCount() {
        Double expected = 320.0;
        Double actual = customerBillingService.customerCount();
        Assert.assertEquals(expected, actual);
    }
}