package com.zcreate.security.dao;

import com.zcreate.security.pojo.Role;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * Created by gzhhy on 2017-06-10.
 */
public class FunctionDao {
    @Autowired
    private FunctionMapper functionMapper;
    @Autowired
    private RoleMapper roleMapper;

    public List<Role> getRoleByUser(int userID) {
        return null;
    }

    public List<Role> getFunctionByUser(int userID) {
        return null;
    }

}
