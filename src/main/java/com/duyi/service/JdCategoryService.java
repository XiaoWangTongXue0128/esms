package com.duyi.service;

import com.duyi.bean.JdCategory;
import com.duyi.mapper.JdCategoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class JdCategoryService {
    @Autowired
    private JdCategoryMapper jdCategoryMapper;


    public List<JdCategory> selectByParentId(Integer parentId) {
        return jdCategoryMapper.selectByParentId(parentId);
    }

    public JdCategory selectByPrimaryKey(Integer categoryId) {
        return jdCategoryMapper.selectByPrimaryKey(categoryId);
    }

}
