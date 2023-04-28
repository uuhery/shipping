package com.company.project.service.shipment;

import com.baomidou.mybatisplus.extension.service.IService;
import com.company.project.entity.shipping.CustomerBilling;
import com.company.project.entity.shipping.Shipment;

/**
 * 
 *
 * @author wenbin
 * @email *****@mail.com
 * @date 2023-04-28 13:24:41
 */
public interface CustomerBillingService extends IService<CustomerBilling> {

    public boolean saveCustomerBilling(Shipment shipment);
}

