package com.duyi.service;

import com.duyi.bean.JdUser;
import com.duyi.mapper.JdUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

@Service
public class JdUserService {
    @Autowired
    private JdUserMapper jdUserMapper;

    public JdUser login(String loginName) {
        return jdUserMapper.selectByLoginName1(loginName);
    }
    public JdUser login2(String loginName) {
        return jdUserMapper.selectByLoginName2(loginName);
    }


    /**
     * @方法描述:注册方法
     * @author: wang
     * @time: 2024/5/14 4:03
     * @param jdUser
     * @return: java.lang.Boolean
     */
    public Boolean registeredJdUsers(JdUser jdUser) {

        try {
            return jdUserMapper.insertJdUser(jdUser)==1?true:false;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
