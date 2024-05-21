package com.duyi.mapper;

import com.duyi.bean.JdOrder;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface JdOrderMapper {
    int deleteByPrimaryKey(Integer orderId);

    int insertJdOrder(JdOrder jdOrder);

    JdOrder selectByPrimaryKey(Integer orderId);

    List<JdOrder> selectAll();

    int updateByPrimaryKey(JdOrder record);

    int updateOrderStatus(@Param("status") String status, @Param("orderId") int orderId);

    List<JdOrder> selectOrderList(Map<String, Object> map);
}