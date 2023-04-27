package com.company.project.entity.shipping;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.company.project.entity.sys.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Data
@TableName("carrier_billing")
public class CarrierBilling extends BaseEntity implements Serializable {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer carrierId;
    private Integer orderId;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date billingDate;
    private BigDecimal freightCharge;
    private Integer state;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCarrierId() {
        return carrierId;
    }

    public void setCarrierId(Integer carrierId) {
        this.carrierId = carrierId;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Date getBillingDate() {
        return billingDate;
    }

    public void setBillingDate(Date billingDate) {
        this.billingDate = billingDate;
    }

    public BigDecimal getFreightCharge() {
        return freightCharge;
    }

    public void setFreightCharge(BigDecimal freightCharge) {
        this.freightCharge = freightCharge;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }
}