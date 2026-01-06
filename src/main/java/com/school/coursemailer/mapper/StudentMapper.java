package com.school.coursemailer.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Map;

@Mapper
public interface StudentMapper {
    Map<String, Object> selectBySub(@Param("sub") String sub);

    void insertStudent(Map<String, Object> param);

    void updateStudent(Map<String, Object> map);

    Map<String, Object> selectUserMap(String sub);
}
