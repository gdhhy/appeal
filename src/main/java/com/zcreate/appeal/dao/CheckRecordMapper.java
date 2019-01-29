package com.zcreate.appeal.dao;

import com.zcreate.appeal.pojo.CheckRecord;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface CheckRecordMapper {
    List<CheckRecord> getCheckRecord(@Param("param") Map<String, Object> param);

    List<CheckRecord> selectCheckRecord(@Param("param") Map<String, Object> param);

    int insertCheckRecord(@Param("pojo") CheckRecord checkRecord);

    int updateCheckRecord(@Param("pojo") CheckRecord checkRecord);

    int deleteCheckRecord(@Param("checkRecordID") int checkRecordID);
}
