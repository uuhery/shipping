package com.company.project.utilities.kafka;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Component;

@Component
public class KafkaMessageSender {

    private KafkaTemplate<String, String> kafkaTemplate;

    @Autowired
    public KafkaMessageSender(KafkaTemplate<String, String> kafkaTemplate) {
        this.kafkaTemplate = kafkaTemplate;
    }

    public void sendMessage(String topic, Object object) throws JsonProcessingException {
        // 使用ObjectMapper将Java对象序列化为JSON格式的字符串
        ObjectMapper objectMapper = new ObjectMapper();
        String message = objectMapper.writeValueAsString(object);

        // 发送JSON字符串到Kafka
        kafkaTemplate.send(topic, message);
    }
}
