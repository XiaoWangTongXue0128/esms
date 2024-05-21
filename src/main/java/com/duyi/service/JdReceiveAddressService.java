package com.duyi.service;

import com.duyi.bean.JdReceiveAddress;
import com.duyi.mapper.JdReceiveAddressMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @description: 收货地址的服务类
 * @author: wang
 * @time: 2024/5/20 3:51
 */
@Service
public class JdReceiveAddressService {
    @Autowired
    private JdReceiveAddressMapper jdReceiveAddressMapper;

    public JdReceiveAddress selectByUserId(Integer userId) {
        return jdReceiveAddressMapper.selectByUserId(userId);
    }
}
