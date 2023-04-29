package com.company.project.mapper.shipping;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.company.project.entity.shipping.Carrier;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CarrierMapper extends BaseMapper<Carrier> {
}