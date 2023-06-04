package com.company.project.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.company.project.entity.shipping.CarrierBilling;
import com.company.project.entity.shipping.Shipment;

/**
 * 
 *
 * @author wenbin
 * @email *****@mail.com
 * @date 2023-04-26 17:58:48
 */
public interface CarrierBillingService extends IService<CarrierBilling> {

    public boolean saveCarrierBilling(Shipment shipment);
}

