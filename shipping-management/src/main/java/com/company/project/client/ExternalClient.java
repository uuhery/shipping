package com.company.project.client;

import com.company.project.entity.shipping.Customer;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(name="external-service",url="localhost:7101",fallback = ExternalDegradeFeignClient.class)
@Component
public interface ExternalClient {
    @PostMapping("customer/getCustomer")
    Customer getCustomer(@RequestParam(name = "id") Integer id);
}