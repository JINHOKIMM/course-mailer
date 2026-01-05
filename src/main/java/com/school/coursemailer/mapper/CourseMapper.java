package com.school.coursemailer.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CourseMapper {
    List<Map<String, String>> selectCourseList1();

    List<Map<String, String>> selectCourseList2();

    List<Map<String, String>> selectMyCourse(Map<String, String> userMap);

    void insertMyCourse(Map<String, String> userMap);

    void deleteMyCourse(Map<String, String> userMap);

    List<Map<String, String>> selectMyFutureCourse(Map<String, String> userMap);

    List<Map<String, String>> selectAvailableCourseList(Map<String, String> userMap);

    String selectCourseId(Map<String, String> userMap);

    void student_cntUp(Map<String, String> map);

    void student_cntDown(Map<String, String> map);

    boolean isPossibleSwap(Map<String, String> userMap);

    void updatePeriodCourse(Map<String, String> param);

    String selectStudentCourseId(Map<String, String> userMap);

    //void updateMyCourse(Map<String, String> userMap);
}
