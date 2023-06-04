package com.company.project.client;

import com.company.project.entity.shipping.Customer;
import org.springframework.stereotype.Component;

@Component
public class ExternalDegradeFeignClient implements ExternalClient {
    @Override
    public Customer getCustomer(Integer id) {
        throw new RuntimeException("无法获取客户信息，请稍后再试。");
    }
}
