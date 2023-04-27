package com.company.project.service.shipment.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.company.project.entity.shipping.Carrier;
import com.company.project.entity.shipping.Customer;
import com.company.project.mapper.shipping.CarrierMapper;
import com.company.project.mapper.shipping.CustomerMapper;
import com.company.project.service.shipment.CarrierService;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import javax.annotation.Resource;
import java.util.List;


@Service("carrierService")
public class CarrierServiceImpl extends ServiceImpl<CarrierMapper, Carrier> implements CarrierService {
    @Resource
    private CarrierMapper carrierMapper;
    public JSONArray getType() {
        //获取明细
        List<Carrier> list = carrierMapper.selectList(new QueryWrapper<>());
        return JSONArray.parseArray(JSON.toJSONString(list));
    }
}