package com.company.project.entity.shipping;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.company.project.entity.sys.BaseEntity;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;

@Data
@TableName("shipment_rates")
public class ShipmentRate extends BaseEntity implements Serializable {
    @TableId(type = IdType.AUTO)
    private Integer shipmentRateId;
    private Integer carrierId;
    private Integer shipmentTypeId;
    private BigDecimal pricePerKg;
    private BigDecimal pricePerKm;

    public Integer getShipmentRateId() {
        return shipmentRateId;
    }

    public void setShipmentRateId(Integer shipmentRateId) {
        this.shipmentRateId = shipmentRateId;
    }

    public Integer getCarrierId() {
        return carrierId;
    }

    public void setCarrierId(Integer carrierId) {
        this.carrierId = carrierId;
    }

    public Integer getShipmentTypeId() {
        return shipmentTypeId;
    }

    public void setShipmentTypeId(Integer shipmentTypeId) {
        this.shipmentTypeId = shipmentTypeId;
    }

    public BigDecimal getPricePerKg() {
        return pricePerKg;
    }

    public void setPricePerKg(BigDecimal pricePerKg) {
        this.pricePerKg = pricePerKg;
    }

    public BigDecimal getPricePerKm() {
        return pricePerKm;
    }

    public void setPricePerKm(BigDecimal pricePerKm) {
        this.pricePerKm = pricePerKm;
    }
}