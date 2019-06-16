package com.zcreate.security.dao;

import com.zcreate.security.pojo.Role;
//import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Created by hhy on 17-5-5.
 */
//@Mapper
public interface RoleMapper {
    Role getRole(@Param("param") Map<String, Object> param);

    List<Role> selectRole(@Param("param") Map<String, Object> param);

    /*List<Role> selectRoleByUserID(@Param("userID") int userID);*/

    int insertRole(@Param("pojo") Role role);

    int updateRole(@Param("pojo") Role role);

    //int deleteRole(@Param("roleID ") int roleID);
    int deleteRole(@Param("param") Map<String, Object> param);
}
