package com.company.project.service.shipment.impl;

import com.company.project.entity.shipping.Shipment;
import com.company.project.mapper.shipping.ShipmentMapper;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.math.BigDecimal;

@SpringBootTest()
@RunWith(SpringRunner.class)
public class ShipmentServiceImplTest {

    @Autowired
    ShipmentServiceImpl shipmentService;
    @Mock
    ShipmentMapper shipmentMapper;
    @Test
    public void testSaveShipment() {
        Shipment shipment = new Shipment();
        shipment.setCarrierId(2);
        shipment.setSendId(1);
        shipment.setCustomerId(2);
        shipment.setGoodsId(2);
        shipment.setNum(BigDecimal.valueOf(100));
        // 调用被测试的方法
        Shipment result = shipmentService.saveShipment(shipment);
        // 验证保存结果是否符合预期
        Assert.assertNotNull(result.getId());
        Assert.assertEquals("上海市徐汇区虹桥路1234号", result.getOriginAddress());
        Assert.assertEquals("北京市朝阳区建国路555号", result.getDestinationAddress());
        Assert.assertEquals("2000.00", result.getWeight().toString());
        Assert.assertEquals("199999.00", result.getValue().toString());
        Assert.assertNotNull(result.getPickupDate());
        Assert.assertEquals(0, result.getOrderStatus().intValue());
    }
}