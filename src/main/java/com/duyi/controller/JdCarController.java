package com.duyi.controller;

import com.duyi.bean.JdProduct;
import com.duyi.bean.JdUser;
import com.duyi.bean.vo.JdCartItem;
import com.duyi.mapper.JdProductMapper;
import com.duyi.service.JdProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
public class JdCarController {
    @Autowired
    private JdProductService jdProductService;

    //    商品添加到购物车中
    @RequestMapping("/toAddCart")
    public String toAddCart(int productId, HttpServletRequest request) {

        Map<Integer,JdCartItem> car = (Map<Integer, JdCartItem>) request.getSession().getAttribute("cart");
        if (car == null) {
            car = new HashMap<Integer,JdCartItem>();
            request.getSession().setAttribute("cart", car);
        }
        JdProduct jdProduct = jdProductService.selectByPrimaryKey(productId);


        JdCartItem carItem1 = jdProduct.convertToJdCartItem();
        if (car.get(carItem1.getProduct_id()) != null) {
            JdCartItem jdCartItem = car.get(carItem1.getProduct_id());
            jdCartItem.setProduct_count(jdCartItem.getProduct_count() + 1);

        } else {
            car.put(carItem1.getProduct_id(), carItem1);
        }
        int sunm_count = 0;
        double sum_price = 0;
        for (JdCartItem jdCartItem : car.values()) {
            sunm_count += jdCartItem.getProduct_count();
            sum_price += (jdCartItem.getProduct_count() * jdCartItem.getLower_price());
        }

        request.setAttribute("sunm_count", sunm_count);
        request.setAttribute("sunm_price", sum_price);
        return "initCart";
    }

    @RequestMapping("/toMyCart")
    public String toMyCart(HttpServletRequest request) {
        double sum_price = 0;
        Map<Integer, JdCartItem> car = (Map<Integer, JdCartItem>) request.getSession().getAttribute("cart");
        for (JdCartItem jdCartItem : car.values()) {
            sum_price += (jdCartItem.getProduct_count() * jdCartItem.getLower_price());
        }
        request.getSession().setAttribute("sum_price", sum_price);
        return "myCart";
    }

    @RequestMapping("changeQuantity")
    @ResponseBody
    public Map<String, Object> changeQuantity(int product_id, int count, HttpServletRequest request) {


        Map<String, Object> map=new HashMap<String, Object>();
        double sum_price = 0;
        Map<Integer, JdCartItem> car = (Map<Integer, JdCartItem>) request.getSession().getAttribute("cart");
        for (JdCartItem jdCartItem : car.values()) {
            if (jdCartItem.getProduct_id() == product_id) {
                jdCartItem.setProduct_count(count);

            }
            sum_price += (jdCartItem.getProduct_count() * jdCartItem.getLower_price());
        }
        map.put("sum_price", sum_price);
        return map;
    }

    @ResponseBody
    @RequestMapping("/deleteProduct")
    public Map<String, Object> deleteProduct(int product_id, HttpServletRequest request) {
        double sum_price = 0;
        Map<String, Object> map=new HashMap<String, Object>();
        Map<Integer, JdCartItem> car = (Map<Integer, JdCartItem>) request.getSession().getAttribute("cart");
        for (JdCartItem jdCartItem : car.values()) {
            if (jdCartItem.getProduct_id() == product_id) {
                car.remove(jdCartItem.getProduct_id());
                map.put("status", true);
                break;
            }
        }
        for (JdCartItem jdCartItem : car.values()) {
            sum_price += (jdCartItem.getProduct_count() * jdCartItem.getLower_price());
        }

        map.put("sum_price", sum_price);
        return map;
    }
}
