package com.company.project.service.shipment.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.company.project.entity.shipping.Goods;
import com.company.project.mapper.shipping.GoodsMapper;
import com.company.project.service.shipment.GoodsService;
import org.springframework.stereotype.Service;


@Service("goodsService")
public class GoodsServiceImpl extends ServiceImpl<GoodsMapper, Goods> implements GoodsService {


}