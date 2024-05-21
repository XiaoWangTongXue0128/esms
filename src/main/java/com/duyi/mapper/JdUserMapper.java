package com.duyi.mapper;

import com.duyi.bean.JdUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface JdUserMapper {
    int deleteByPrimaryKey(Integer userId);

    int insertJdUser(JdUser jdUser);

    JdUser selectByPrimaryKey(Integer userId);

    List<JdUser> selectAll();

    int updateByPrimaryKey(JdUser record);

    JdUser selectByLoginName1(String loginName);

    JdUser selectByLoginName2(@Param("loginName") String loginName);
}