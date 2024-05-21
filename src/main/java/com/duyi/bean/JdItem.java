package com.duyi.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class JdItem implements Serializable {

    private static final long serialVersionUID = -2769043719984404110L;
    private Integer id;

    private Integer orderId;

    private Integer productId;

    private Integer productNum;

    private Double productPrice;


}