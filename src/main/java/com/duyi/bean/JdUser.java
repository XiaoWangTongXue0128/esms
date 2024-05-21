package com.duyi.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class JdUser implements Serializable {

    private static final long serialVersionUID = 6405287617418606435L;
    private Integer userId;

    private String loginName;

    private String nickName;

    private String realName;

    private Integer gradeId;

    private String password;

    private String email;

    private String province;

    private String recommender;

    private String sex;

    private Timestamp birth;

    private String location;

    private String school;

    private String company;

    private String cardInt;

    private String mobile;

    private String phone;

    private String msn;

    private String qq;

    private String website;

    private String sendAddress;

    private String zipcode;

    private String hobby;

    private String verifyFlag;

    private String verifyCode;

    private Timestamp lastLoginTime;

    private String lastLoginIp;

    private String area;

    private String headPic;


}