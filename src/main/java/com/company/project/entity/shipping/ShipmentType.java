package com.company.project.entity.shipping;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.company.project.entity.sys.BaseEntity;
import lombok.Data;

import java.io.Serializable;

@Data
@TableName("shipment_types")
public class ShipmentType extends BaseEntity implements Serializable {
    @TableId(type = IdType.AUTO)
    private Integer shipmentTypeId;
    private String name;
    private String description;

    public Integer getShipmentTypeId() {
        return shipmentTypeId;
    }

    public void setShipmentTypeId(Integer shipmentTypeId) {
        this.shipmentTypeId = shipmentTypeId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}