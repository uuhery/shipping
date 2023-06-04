package com.company.project.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.company.project.entity.shipping.Customer;

public interface CustomerService extends IService<Customer> {

    public Customer getCustomer(Integer id);
}