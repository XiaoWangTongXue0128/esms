package com.duyi.test;

import com.duyi.bean.JdReceiveAddress;
import com.duyi.service.JdReceiveAddressService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class JdReceiveAddressTest {
    public static void main(String[] args) {
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        JdReceiveAddressService jdReceiveAddressService = applicationContext.getBean(JdReceiveAddressService.class);
        JdReceiveAddress jdReceiveAddress = jdReceiveAddressService.selectByUserId(1);
        System.out.println(jdReceiveAddress);

    }
}
