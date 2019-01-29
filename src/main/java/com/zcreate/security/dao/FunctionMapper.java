package com.zcreate.security.dao;

import com.zcreate.security.pojo.Function;
//import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Created by hhy on 17-5-5.
 */
//@Mapper
public interface FunctionMapper {
    List<Function> getFunction(@Param("param") Map<String, Object> param);

    int insertFunction(@Param("pojo") Function func);

    int updateFunction(@Param("pojo") Function func);

    int deleteFunction(@Param("functionID ") int funcID);
}
