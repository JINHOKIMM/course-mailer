package com.school.coursemailer.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CourseMapper {
    List<Map<String, String>> selectCourseList(Map<String,String> userMap);

    List<Map<String, String>> selectMyCourse(Map<String, String> userMap);

    void insertMyCourse(Map<String, String> userMap);

    void deleteMyCourse(Map<String, String> userMap);

    //void updateMyCourse(Map<String, String> userMap);
}
