package com.duyi.controller;

import com.duyi.bean.JdCategory;
import com.duyi.bean.JdUser;
import com.duyi.service.JdCategoryService;
import com.duyi.service.JdUserService;
import com.duyi.util.Const;
import com.duyi.util.Md5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.List;

@Controller
public class JdUserController {

    @Autowired
    private JdUserService jdUserService;

    @Autowired
    private JdCategoryService jdCategoryService;

    @RequestMapping("/toHello")
    public String toHello() {

        return "hello";
    }

    @RequestMapping("/toLogin")
    public String toLogin() {

        return "login";
    }

    /**
     * @param loginName
     * @param password
     * @author: wang
     * @time: 2024/5/13 22:50
     * @description:
     * @return: java.lang.String
     */
    @RequestMapping("login.do")
    public String login(String loginName, String password, HttpServletRequest request) {

        password = Md5Util.md5Salt(password, loginName);


        JdUser jdUser = jdUserService.login(loginName);
        if (jdUser == null) {
            request.setAttribute("msg", "账号不存在");

            return "login";
        }
        if (!jdUser.getPassword().equals(password)) {
            request.setAttribute("msg", "密码错误！");
            return "login";
        }
        List<JdCategory> jdCategoryList = jdCategoryService.selectByParentId(Const.jdCategoryId);
        request.getSession().setAttribute("jdUser", jdUser);
        request.setAttribute("jdCategoryList", jdCategoryList);

        return "book";
    }

    @RequestMapping("/toRegister")
    public String toRegister() {

        return "register";
    }

    /**
     * @param jdUser
     * @param request
     * @方法描述: 注册
     * @author: wang
     * @time: 2024/5/14 4:04
     * @return: java.lang.String
     */
    @RequestMapping("/register.do")
    public String registeredJdUsers(JdUser jdUser, HttpServletRequest request) {
        jdUser.setPassword(Md5Util.md5Salt(jdUser.getPassword(), jdUser.getLoginName()));

        jdUser.setLastLoginTime(new Timestamp(System.currentTimeMillis()));
        Boolean value = jdUserService.registeredJdUsers(jdUser);
        if (!value) {
            request.setAttribute("msg", "当前用户名已注册");
            return "register";
        }
        request.setAttribute("msg", "注册成功");
        return "registerOk";
    }

    @RequestMapping("/book")
    public String getBook(HttpServletRequest request) {
        JdUser jdUser = (JdUser) request.getSession().getAttribute("jdUser");
        if (jdUser != null) {
            List<JdCategory> jdCategoryList = jdCategoryService.selectByParentId(Const.jdCategoryId);

            request.setAttribute("jdCategoryList", jdCategoryList);
            return "book";
        }
        return "login";
    }



}
