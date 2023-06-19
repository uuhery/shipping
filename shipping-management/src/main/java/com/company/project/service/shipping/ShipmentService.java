package com.company.project.service.shipping;


import com.baomidou.mybatisplus.extension.service.IService;
import com.company.project.entity.shipping.Shipment;

/**
 * 
 *
 * @author wenbin
 * @email *****@mail.com
 * @date 2023-04-16 20:58:10
 */
public interface ShipmentService extends IService<Shipment> {

    Shipment saveShipment(Shipment shipment);
}

