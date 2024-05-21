package com.duyi.mapper;

import com.duyi.bean.JdReceiveAddress;
import java.util.List;

public interface JdReceiveAddressMapper {
    int deleteByPrimaryKey(Integer reveiveAddressId);

    int insert(JdReceiveAddress record);

    JdReceiveAddress selectByPrimaryKey(Integer reveiveAddressId);

    List<JdReceiveAddress> selectAll();

    int updateByPrimaryKey(JdReceiveAddress record);

    JdReceiveAddress selectByUserId(Integer userId);
}