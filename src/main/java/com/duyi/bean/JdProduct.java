package com.duyi.bean;

import com.duyi.bean.vo.JdCartItem;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class JdProduct implements Serializable {

    private static final long serialVersionUID = 210858025557306197L;
    private Integer productId;

    private String name;

    private String keywords;

    private Date addTime;

    private String picture;

    private String bigPicture;

    private Integer fixedPrice;

    private Integer lowerPrice;

    private String description;

    private String author;

    private String publishing;

    private Date publishTime;

    private String isbn;

    private String language;

    private String whichEdtion;

    private String totalPage;

    private String bindLayout;

    private String bookSize;

    private String editorDescription;

    private String catalog;

    private String bookSummary;

    private String authorSummary;

    private String extracts;

    private Date printTime;

    private Integer printInt;

    private String paperType;

    private String printFrequency;

    public JdCartItem convertToJdCartItem() {
        JdCartItem jdCartItem = new JdCartItem();
        jdCartItem.setProduct_id(getProductId());
        jdCartItem.setPicture(getPicture());
        jdCartItem.setName(getName());
        jdCartItem.setLower_price(getLowerPrice());
        jdCartItem.setBack_money(0.0);
        jdCartItem.setScore(0);
        jdCartItem.setProduct_count(1);
        return jdCartItem;
    }


}