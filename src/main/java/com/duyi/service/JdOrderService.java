package com.duyi.service;

import com.duyi.bean.JdItem;
import com.duyi.bean.JdOrder;
import com.duyi.mapper.JdItemMapper;
import com.duyi.mapper.JdOrderMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class JdOrderService {
    @Autowired
    private JdOrderMapper jdOrderMapper;

    @Autowired
    private JdItemMapper jdItemMapper;

    public int insertJdOrder(JdOrder jdOrder) {
        return jdOrderMapper.insertJdOrder(jdOrder);
    }

    @Transactional
    public  void  addOrderAndItems(JdOrder  order){
        int  osf = jdOrderMapper.insertJdOrder(order);
        List<JdItem> items = order.getItems();


        int  isf = 0;
        for (int i=0;i<items.size();i++){
            // 给每个条目设置 订单生成的id
            items.get(i).setOrderId(order.getOrderId());
            isf = jdItemMapper.insertJdItem(items.get(i));
            if(isf == 0){
                break;
            }
        }
//        测试方法
//        isf = 0;
        if(osf == 0 || isf == 0){
            throw new RuntimeException("订单插入失败");
        }
    }
    public boolean updateOrderStatus(String status,Integer orderId ) {
        return jdOrderMapper.updateOrderStatus(status, orderId)==10 ? true : false;
    }

    public List<JdOrder> selectOrderList(Map<String, Object> map) {
        return jdOrderMapper.selectOrderList(map);
    }


}
