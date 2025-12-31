package com.school.coursemailer.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CourseMapper {
    List<Map<String, String>> selectCourseCond(String sub);
}
