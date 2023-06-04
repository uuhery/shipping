package com.company.project.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.company.project.entity.shipping.Carrier;
import com.company.project.service.CarrierService;
import com.company.project.mapper.CarrierMapper;
import org.springframework.stereotype.Service;

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