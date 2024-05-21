package com.duyi.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class JdOrder implements Serializable {

    private static final long serialVersionUID = -2129525974786254954L;
    private Integer orderId;

    private Integer userId;

    private String status;

    private Date orderTime;

    private Double totalPrice;

    private Integer paymentId;

    private Integer invoiceId;

    private Integer reveiveAddressId;

    private String bak;

    private List<JdItem> items;


}