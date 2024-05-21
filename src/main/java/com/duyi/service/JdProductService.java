package com.duyi.service;

import com.duyi.bean.JdProduct;
import com.duyi.mapper.JdProductMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class JdProductService {
    @Autowired
    private JdProductMapper jdProductMapper;
    public List<JdProduct> selectProductList(@Param("categoryId") Integer categoryId,
                                             @Param("order_std")String order_std,
                                             @Param("order_type")String order_type,
                                             @Param("start_pos")Integer start_pos,
                                             @Param("page_size")Integer page_size) {
        return jdProductMapper.selectProductList(categoryId, order_std, order_type, start_pos, page_size);
    }
//    获取产品总数
    public int selectProductSum(Integer categoryId) {
        return jdProductMapper.selectProductSum(categoryId);
    }

    public JdProduct selectByPrimaryKey(Integer productId) {
        return jdProductMapper.selectByPrimaryKey(productId);
    }
}
