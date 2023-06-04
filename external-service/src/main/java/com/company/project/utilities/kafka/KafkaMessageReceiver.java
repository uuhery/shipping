package com.company.project.utilities.kafka;

import com.company.project.entity.shipping.Shipment;
import com.company.project.service.CarrierBillingService;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;

@Component
public class KafkaMessageReceiver {

    @Resource
    private ObjectMapper objectMapper;

    @Resource
    CarrierBillingService carrierBillingService;

    @KafkaListener(
        topics = "carrier-billing-events",
        groupId = "payment"
    )
    public void receiveMessage(String message) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            Shipment shipment = objectMapper.readValue(message, Shipment.class);
            // 处理接收到的消息并创建承运人支付订单
            carrierBillingService.saveCarrierBilling(shipment);
        } catch (IOException e) {
            // 处理反序列化异常
            e.printStackTrace();
        }
    }
}
