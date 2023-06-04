package com.company.project.service.shipping.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.company.project.entity.shipping.Goods;
import com.company.project.mapper.shipping.GoodsMapper;
import com.company.project.service.shipping.GoodsService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


@Service("goodsService")
public class GoodsServiceImpl extends ServiceImpl<GoodsMapper, Goods> implements GoodsService {
    @Resource
    private GoodsMapper goodsMapper;
    public JSONArray getType() {
        //获取明细
        List<Goods> list = goodsMapper.selectList(new QueryWrapper<>());
        return JSONArray.parseArray(JSON.toJSONString(list));
    }
}