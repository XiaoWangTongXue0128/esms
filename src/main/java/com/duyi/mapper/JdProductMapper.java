package com.duyi.mapper;

import com.duyi.bean.JdProduct;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface JdProductMapper {
    int deleteByPrimaryKey(Integer productId);

    int insert(JdProduct record);

    JdProduct selectByPrimaryKey(@Param("productId") Integer productId);

    List<JdProduct> selectAll();

    int updateByPrimaryKey(JdProduct record);

    List<JdProduct> selectProductList(@Param("categoryId") Integer categoryId,
                                      @Param("order_std")String order_std,
                                      @Param("order_type")String order_type,
                                      @Param("start_pos")Integer start_pos,
                                      @Param("page_size")Integer page_size);

//     获取产品总数
    int selectProductSum(@Param("categoryId") Integer categoryId);
}