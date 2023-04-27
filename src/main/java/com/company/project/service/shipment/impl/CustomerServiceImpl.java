package com.company.project.service.shipment.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.company.project.entity.shipping.Customer;
import com.company.project.mapper.shipping.CustomerMapper;
import com.company.project.service.shipment.CustomerService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("customerService")
public class CustomerServiceImpl extends ServiceImpl<CustomerMapper, Customer> implements CustomerService {
    @Resource
    private CustomerMapper customerMapper;
    public JSONArray getType() {
        //获取明细
        List<Customer> list = customerMapper.selectList(new QueryWrapper<>());
        return JSONArray.parseArray(JSON.toJSONString(list));
    }

}