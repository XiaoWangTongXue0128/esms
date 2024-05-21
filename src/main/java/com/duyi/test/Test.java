package com.duyi.test;

import com.duyi.bean.JdCategory;
import com.duyi.bean.JdUser;
import com.duyi.service.JdCategoryService;
import com.duyi.service.JdUserService;
import com.duyi.util.Md5Util;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.ArrayList;
import java.util.List;

public class Test {
    public static void main(String[] args) {
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
//        JdUserService jdUserService = applicationContext.getBean(JdUserService.class);
//        JdUser jdUser1 = jdUserService.login("wtc");
//        JdUser jdUser2 = jdUserService.login2("mq");
//        System.out.println(jdUser1);
//        System.out.println("--------------------");
//        System.out.println(jdUser2);

//        JdUser jdUser = new JdUser();
//        jdUser.setLoginName("wtc1");
//        jdUser.setPassword("123");
//        jdUser.setEmail("1440057838@qq.com");
//        jdUser.setRecommender("mq");
//        Boolean value = jdUserService.registeredJdUsers(jdUser);
//        System.out.println(value);
//        System.out.println(Md5Util.md5Str(jdUser.getPassword()));
//        System.out.println(Md5Util.md5Str(jdUser.getLoginName()));
//        System.out.println(Md5Util.md5Salt(jdUser.getPassword(), jdUser.getLoginName()).length());
//        System.out.println(Md5Util.md5Salt(jdUser.getPassword(), jdUser.getLoginName()));


//========================================

        JdCategoryService jdCategoryService = applicationContext.getBean(JdCategoryService.class);
        List<JdCategory> jdCategoryArrayList = jdCategoryService.selectByParentId(1);
        for (JdCategory jdCategory : jdCategoryArrayList) {
            System.out.println(jdCategory);
        }
    }
}
