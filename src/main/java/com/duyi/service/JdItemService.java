package com.duyi.service;

import com.duyi.bean.JdItem;
import com.duyi.mapper.JdItemMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class JdItemService {
    @Autowired
    private JdItemMapper jdItemMapper;
    public int insertJdItem(JdItem jdItem) {
        return jdItemMapper.insertJdItem(jdItem);
    }
}
