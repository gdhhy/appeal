package com.zcreate.security.dao;

import com.zcreate.security.pojo.*;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hhy on 17-5-5.
 */
public class UserDao {
    @Autowired
    private UserMapper userMapper;

    public List<User> getUserbyUsername(String username) {
        Map<String,Object> param=new HashMap<>();
        param.put("username",username);
        return userMapper.getUser(param);
    }

    public int saveUser(User user) {
        int affectedRowCount;
        affectedRowCount = userMapper.updateUser(user);

        if (affectedRowCount == 0)
            affectedRowCount = userMapper.insertUser(user);

        return affectedRowCount;
    }

    public int deleteUser(int userID) {
        return userMapper.deleteUser(userID);
    }
}
