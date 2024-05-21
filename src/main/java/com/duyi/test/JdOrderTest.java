package com.duyi.test;

import com.duyi.bean.JdItem;
import com.duyi.bean.JdOrder;
import com.duyi.service.JdOrderService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class JdOrderTest {
    public static void main(String[] args) {
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        JdOrderService jdOrderService = applicationContext.getBean(JdOrderService.class);
//        JdOrder jdOrder = new JdOrder();
//        jdOrder.setUserId(1);
//        jdOrder.setInvoiceId(1);
//        jdOrder.setOrderTime(new Timestamp(System.currentTimeMillis()));
//        jdOrder.setPaymentId(1);
//        jdOrder.setBak("测试");
//        jdOrder.setReveiveAddressId(1);
//        jdOrder.setStatus("订单已生成");
//        jdOrder.setTotalPrice(100.0);
//        System.out.println(jdOrderService.insertJdOrder(jdOrder));
//        System.out.println(jdOrder);

        JdOrder  jdOrder  = new JdOrder();
        jdOrder.setInvoiceId(1);
        jdOrder.setOrderTime(new Timestamp(System.currentTimeMillis()));
        jdOrder.setPaymentId(1);
        jdOrder.setReveiveAddressId(1);
        jdOrder.setStatus("订单已经生成");
        jdOrder.setTotalPrice(100.0);
        jdOrder.setUserId(1);
        jdOrder.setBak("测试");
        // 给订单产生 两个详情
        JdItem item  = new JdItem();
        item.setOrderId(jdOrder.getOrderId());
        item.setProductId(1);
        item.setProductNum(2);
        item.setProductPrice(11.28);

        JdItem item2  = new JdItem();
        item2.setOrderId(jdOrder.getOrderId());
        item2.setProductId(1);
        item2.setProductNum(2);
        item2.setProductPrice(11.28);
        List<JdItem> items  = new ArrayList<>();
        items.add(item);
        items.add(item2);
        jdOrder.setItems(items);
        jdOrderService.addOrderAndItems(jdOrder);


    }

}
