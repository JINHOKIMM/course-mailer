package com.school.coursemailer.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CourseMapper {
    List<Map<String, String>> selectCourseList1();

    List<Map<String, String>> selectCourseList2();

    List<Map<String, Object>> selectPlanned(Map<String, Object> userMap);
    List<Map<String, Object>> selectFinal(Map<String, Object> userMap);

    void insertMyCourse(Map<String, Object> userMap);

    void deleteMyCourse(Map<String, Object> userMap);

    List<Map<String, Object>> selectAvailableCourseList(Map<String, Object> userMap);

    String selectCourseId(Map<String, Object> userMap);

    void student_cntUp(Map<String, Object> map);

    void student_cntDown(Map<String, String> map);

    boolean isPossibleSwap(Map<String, Object> userMap);

    void updatePeriodCourse(Map<String, String> param);

    String selectStudentCourseId(Map<String, Object> userMap);

    List<Map<String, Object>> selectMyCourse(Map<String, Object> userMap);

    String selectRoom(Map<String, Object> userMap);

    //void updateMyCourse(Map<String, String> userMap);
}
