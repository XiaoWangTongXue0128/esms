package com.duyi.mapper;

import com.duyi.bean.JdCategory;
import java.util.List;

public interface JdCategoryMapper {
    int deleteByPrimaryKey(Integer categoryId);

    int insert(JdCategory record);

    List<JdCategory> selectByParentId(Integer parentId);

    JdCategory selectByPrimaryKey(Integer categoryId);

    List<JdCategory> selectAll();

    int updateByPrimaryKey(JdCategory record);
}