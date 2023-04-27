package com.company.project.service.shipment.impl;

import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.alibaba.fastjson.JSON;
import com.company.project.entity.shipping.ShipmentType;
import com.company.project.mapper.shipping.ShipmentTypeMapper;
import com.company.project.service.shipment.ShipmentTypeService;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import javax.annotation.Resource;
import java.util.List;


@Service("shipmentTypeService")
public class ShipmentTypeServiceImpl extends ServiceImpl<ShipmentTypeMapper, ShipmentType> implements ShipmentTypeService {
    @Resource
    private ShipmentTypeMapper shipmentTypeMapper;
    public JSONArray getType() {
        //获取明细
        List<ShipmentType> list = shipmentTypeMapper.selectList(new QueryWrapper<>());
        return JSONArray.parseArray(JSON.toJSONString(list));
    }
}