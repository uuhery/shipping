package com.company.project.service.shipment.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.toolkit.SqlHelper;
import com.company.project.entity.shipping.CarrierBilling;
import com.company.project.entity.shipping.Shipment;
import com.company.project.entity.shipping.ShipmentRate;
import com.company.project.mapper.shipping.CarrierBillingMapper;
import com.company.project.mapper.shipping.ShipmentRateMapper;
import com.company.project.service.shipment.CarrierBillingService;
import com.company.project.service.shipment.ShipmentRateService;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;


@Service("carrierBillingService")
public class CarrierBillingServiceImpl extends ServiceImpl<CarrierBillingMapper, CarrierBilling> implements CarrierBillingService {

    @Resource
    ShipmentRateMapper shipmentRateMapper;

    public boolean saveCarrierBilling(Shipment shipment) {
        CarrierBilling carrierBilling = new CarrierBilling();
        carrierBilling.setCarrierId(shipment.getCarrierId());
        carrierBilling.setOrderId(shipment.getId());
        carrierBilling.setCreateDate(new Date());
        LambdaQueryWrapper<ShipmentRate> queryWrapper = Wrappers.lambdaQuery();
        queryWrapper.eq(ShipmentRate::getShipmentTypeId, shipment.getShipmentTypeId());
        queryWrapper.eq(ShipmentRate::getRelatedId, shipment.getCarrierId());
        ShipmentRate shipmentRate = shipmentRateMapper.selectOne(queryWrapper);
        carrierBilling.setFreightCharge(shipment.getWeight().multiply(shipmentRate.getPricePerKg()));
        return SqlHelper.retBool(this.getBaseMapper().insert(carrierBilling));
    }

    public Double carrierCount() {
        LambdaQueryWrapper<CarrierBilling> queryWrapper = Wrappers.lambdaQuery();
        queryWrapper.eq(CarrierBilling::getState, 1);
        List<CarrierBilling> list = this.baseMapper.selectList(queryWrapper);
        Double total = 0.0;
        for(CarrierBilling c:list) {
            total += Double.parseDouble(c.getFreightCharge().toString());
        }
        System.out.println(total);
        return Double.parseDouble(total.toString());
    }
}