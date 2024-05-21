package com.duyi.bean.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Objects;

/**
 * @author gdx
 * @description 购物车条目类
 * @date 2020/1/6
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class JdCartItem implements Serializable {

    private static final long serialVersionUID = -3837026706750501946L;


    private  int  product_id;
    private  String picture;
    private  String name;
    private  double lower_price;
    private  double back_money;
    private  double  score;
    private  int   product_count;

}
