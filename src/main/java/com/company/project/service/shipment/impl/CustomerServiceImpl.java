package com.company.project.service.shipment.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.company.project.entity.shipping.Customer;
import com.company.project.mapper.shipping.CustomerMapper;
import com.company.project.service.shipment.CustomerService;
import org.springframework.stereotype.Service;

@Service("customerService")
public class CustomerServiceImpl extends ServiceImpl<CustomerMapper, Customer> implements CustomerService {


}