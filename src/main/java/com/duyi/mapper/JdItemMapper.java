package com.duyi.mapper;

import com.duyi.bean.JdItem;
import java.util.List;

public interface JdItemMapper {
    int deleteByPrimaryKey(Integer id);

    int insertJdItem(JdItem jdItem);

    JdItem selectByPrimaryKey(Integer id);

    List<JdItem> selectAll();

    int updateByPrimaryKey(JdItem record);
}