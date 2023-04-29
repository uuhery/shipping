package com.company.project.service.shipment.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.company.project.entity.shipping.Shipment;
import com.company.project.entity.shipping.ShipmentType;
import com.company.project.mapper.shipping.CarrierBillingMapper;
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
import static org.mockito.Mockito.when;

@SpringBootTest()
@RunWith(SpringRunner.class)
public class CarrierBillingServiceImplTest {
    @Autowired
    private CarrierBillingServiceImpl carrierBillingService;
    @Mock
    private ShipmentTypeMapper shipmentTypeMapper;
    @Mock
    private CarrierBillingMapper carrierBillingMapper;
    @Test
    public void testSaveCustomerBilling() {
        Shipment shipment = new Shipment();
        shipment.setId(12);
        shipment.setCarrierId(2);
        shipment.setShipmentTypeId(2);
        shipment.setWeight(BigDecimal.valueOf(2000));
        ShipmentType shipmentType = new ShipmentType();
        shipmentType.setId(2);
        shipmentType.setPrice(BigDecimal.valueOf(16));
        when(shipmentTypeMapper.selectOne(new QueryWrapper<>())).thenReturn(shipmentType);
        when(carrierBillingMapper.insert(any())).thenReturn(1);
        boolean result = carrierBillingService.saveCarrierBilling(shipment);
        assertTrue(result);
    }

    @Test
    public void testCustomerCount() {
        Double expected = 24240.0;
        Double actual = carrierBillingService.carrierCount();
        Assert.assertEquals(expected, actual);
    }
}