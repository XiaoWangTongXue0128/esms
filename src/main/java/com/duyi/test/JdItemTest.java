package com.duyi.test;

import com.duyi.bean.JdItem;
import com.duyi.service.JdItemService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class JdItemTest {
    public static void main(String[] args) {
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        JdItemService jdItemService = applicationContext.getBean(JdItemService.class);
        JdItem jdItem = new JdItem();
        jdItem.setOrderId(1);
        jdItem.setProductId(1);
        jdItem.setProductNum(1);
        jdItem.setProductPrice(100.0);
        System.out.println(jdItemService.insertJdItem(jdItem));
        System.out.println(jdItem);

    }
}
