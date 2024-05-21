package com.duyi.controller;

import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.config.AlipayConfig;
import com.duyi.bean.JdOrder;
import com.duyi.bean.JdReceiveAddress;
import com.duyi.bean.JdUser;
import com.duyi.bean.vo.JdCartItem;
import com.duyi.service.JdOrderService;
import com.duyi.service.JdReceiveAddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.*;

/**
 * @description: 订单控制器
 * @author: wang
 * @time: 2024/5/20 3:09
 */

@Controller
public class JdOrderController {

    @Autowired
    private JdReceiveAddressService jdReceiveAddressService;
    @Autowired
    private JdOrderService jdOrderService;


    @RequestMapping("/orderInfoSure")
    public String orderInfoSure(HttpServletRequest request) {
        JdUser jdUser = (JdUser) request.getSession().getAttribute("jdUser");
        JdReceiveAddress address = jdReceiveAddressService.selectByUserId(jdUser.getUserId());

        Map<Integer, JdCartItem> car = (Map<Integer, JdCartItem>) request.getSession().getAttribute("cart");
        double sum_price = 0;
        for (JdCartItem jdCartItem : car.values()) {
            sum_price += (jdCartItem.getProduct_count() * jdCartItem.getLower_price());
        }

        request.setAttribute("sum_price", sum_price);

        request.setAttribute("address", address);
        return "orderInfoSure";
    }

    @RequestMapping("/orderSubmit")
    @ResponseBody
    public Map<String, String> orderSubmit(@RequestBody JdOrder jdOrder,HttpServletRequest request) {
        JdUser  jdUser  =  (JdUser)request.getSession().getAttribute("jdUser");
        Map<String,String>  res  = new HashMap<>();
        res.put("location","orderSuccess");
        double  sum_price = 0.0;
        Map<Integer, JdCartItem> car = (Map<Integer, JdCartItem>)request.getSession().getAttribute("cart");
        for(JdCartItem temp:car.values()){
            sum_price += temp.getLower_price()*temp.getProduct_count();
        }
        res.put("sum_price",sum_price+"");
        jdOrder.setOrderId(jdOrder == null ? -1 : jdOrder.getOrderId());
        jdOrder.setOrderTime(new Timestamp(System.currentTimeMillis()));
        jdOrder.setPaymentId(1);
        jdOrder.setInvoiceId(1);

        jdOrderService.addOrderAndItems(jdOrder);
        res.put("orderId",jdOrder.getOrderId()+"");

        return res;
    }
    @RequestMapping("/orderSuccess")
    public String  orderSuccess(HttpServletRequest request) {
        // 随时计算总价格的
        double  sum_price = 0.0;
        Map<Integer, JdCartItem> car = (Map<Integer, JdCartItem>)request.getSession().getAttribute("cart");
        for(JdCartItem temp:car.values()){
            sum_price += temp.getLower_price()*temp.getProduct_count();
        }
        String  orderId = request.getParameter("orderId");
        request.setAttribute("sum_price",sum_price);
        request.setAttribute("orderId",orderId);
        return "orderSuccess";
    }

    @RequestMapping("/orderInfo")
    public String  orderInfo(HttpServletRequest request) {
        double  sum_price = 0.0;
        Map<Integer, JdCartItem> car = (Map<Integer, JdCartItem>)request.getSession().getAttribute("cart");
        for(JdCartItem temp:car.values()){
            sum_price += temp.getLower_price()*temp.getProduct_count();
        }
        String  orderId = request.getParameter("orderId");
        request.getSession().setAttribute("sum_price",sum_price);
        request.setAttribute("orderId",orderId);
        return  "orderInfo";
    }

    @RequestMapping("/payReturn")
    public String  payReturn(HttpServletRequest request) throws Exception{
        //获取支付宝GET过来反馈信息
        Map<String,String> params = new HashMap<String,String>();
        Map<String,String[]> requestParams = request.getParameterMap();
        for (Iterator<String> iter = requestParams.keySet().iterator(); iter.hasNext();) {
            String name = (String) iter.next();
            String[] values = (String[]) requestParams.get(name);
            String valueStr = "";
            for (int i = 0; i < values.length; i++) {
                valueStr = (i == values.length - 1) ? valueStr + values[i]
                        : valueStr + values[i] + ",";
            }
            //乱码解决，这段代码在出现乱码时使用
            valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
            params.put(name, valueStr);
        }

        boolean signVerified = AlipaySignature.rsaCheckV1(params, AlipayConfig.alipay_public_key, AlipayConfig.charset, AlipayConfig.sign_type); //调用SDK验证签名

        //——请在这里编写您的程序（以下代码仅作参考）——
        if(signVerified) {
            //商户订单号
            String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");

            //支付宝交易号
            String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");

            //付款金额
            String total_amount = new String(request.getParameter("total_amount").getBytes("ISO-8859-1"),"UTF-8");
            request.setAttribute("orderId",out_trade_no);
            request.setAttribute("sum_price",total_amount);
            // 更新数据   把 订单状态 由 等待付款 改成 支付成功
            boolean of = jdOrderService.updateOrderStatus("支付成功",
                    Integer.parseInt(out_trade_no));
            if(!of){
                request.setAttribute("payMsg","更新订单状态失败");
            }
            request.setAttribute("payMsg","支付成功");
            return "orderInfo";
            //out.println("trade_no:"+trade_no+"<br/>out_trade_no:"+out_trade_no+"<br/>total_amount:"+total_amount);
        }else {
            //out.println("验签失败");
            // 即使验证签名 失败其实也付款成功了   这时候你可以记录日志
        }
        return  "";
    }
    /**订单列表  显示当前用户的订单列表 */
    @RequestMapping("/orderList")
    public  String   orderList(HttpServletRequest request){
        // 根据条件 获取当前用户的订单列表
        JdUser  jdUser  =  (JdUser)request.getSession().getAttribute("jdUser");
//        String order_time = request.getParameter("orderTime");
        String status = request.getParameter("status");
        Map<String, Object> map = new HashMap<>();
//        if (order_time != null && order_time != "") {

//            map.put("orderTime", new Timestamp(Long.parseLong(order_time)));
//        }
        if (status != null && status != "") {
            map.put("status", status);
        }
        map.put("userId", jdUser.getUserId());
        List<JdOrder> orderList = jdOrderService.selectOrderList(map);
        request.setAttribute("orderList", orderList);
        return   "orderList";
    }
}
