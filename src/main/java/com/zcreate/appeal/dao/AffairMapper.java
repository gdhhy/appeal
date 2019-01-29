package com.zcreate.appeal.dao;

import com.zcreate.appeal.pojo.Affair;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface AffairMapper {
    List<Affair> getAffair(@Param("param") Map<String, Object> param);

    List<Affair> selectAffair(@Param("param") Map<String, Object> param);

    int insertAffair(@Param("pojo") Affair affair);

    int updateAffair(@Param("pojo") Affair affair);

    int deleteAffair(@Param("affairID") int affairID);
}
