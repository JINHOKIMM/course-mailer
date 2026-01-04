package com.school.coursemailer.service;

import com.school.coursemailer.mapper.CourseMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class CourseService {
    private final CourseMapper courseMapper;

    public CourseService(CourseMapper courseMapper) {
        this.courseMapper = courseMapper;
    }

    public List<Map<String, String>> selectCourseList(Map<String,String> userMap) {
        return courseMapper.selectCourseList(userMap);
    };

    public List<Map<String, String>> selectMyCourse(Map<String, String> userMap) {
        return courseMapper.selectMyCourse(userMap);
    }

    @Transactional
    public void updateMyCourse(Map<String, String> userMap, Map<String, Object> body) {

        String studentId =  String.valueOf(userMap.get("student_id"));
        String status = (String) body.get("status");

        List<Map<String, String>> courses =
                (List<Map<String, String>>) body.get("courses");

        if (courses == null || courses.isEmpty()) {
            throw new IllegalArgumentException("courses is empty or null");
        }

        // 1️⃣ 해당 status 전체 삭제
        courseMapper.deleteMyCourse(Map.of(
                "student_id", studentId,
                "status", status
        ));

        // 2️⃣ 선택한 과목들 insert
        for (Map<String, String> course : courses) {
            course.put("student_id", studentId);
            course.put("status", status);
            courseMapper.insertMyCourse(course);
            log.info("course === {}", course);
        }
    }

    public List<Map<String, String>> selectMyFutureCourse(Map<String, String> userMap) {
        return courseMapper.selectMyFutureCourse(userMap);
    }

    public List<Map<String, String>> selectAvailableCourseList(Map<String, String> userMap, String period) {
        userMap.put("period",period);
        return courseMapper.selectAvailableCourseList(userMap);
    }

    @Transactional
    public Map<String,String> updateMyPeriod(Map<String, String> userMap) {
        Map<String,String> result = new HashMap<>();

        // 정원 확인 로직 (해당 과목으로 변경 가능한지)
        if(!courseMapper.isPossibleSwap(userMap)){

            result.put("res","010");
            result.put("msg","이미 정원이 꽉찬 과목입니다.");
            return result;
        }

        // 기존 course_id 가져오기
        String course_id = courseMapper.selectCourseId(userMap);

        Map<String,String> param = new HashMap<>();
        param.put("course_id",course_id);
        param.put("period",userMap.get("period"));

        log.info("기존 course_id ===" + param.get("course_id"));
        log.info("기존 period ===" + param.get("period"));

        /* 기존 선택한 과목 정원 -1 */
        courseMapper.student_cntDown(param);

        /* 현재 선택한 과목 정원 +1 */
        courseMapper.student_cntUp(userMap);

        // student_course 테이블의 id 가져오기(시퀀스)
        String id = courseMapper.selectStudentCourseId(userMap);

        param.put("nextCourseId", userMap.get("course_id"));
        param.put("id", id);
        courseMapper.updatePeriodCourse(param);

        result.put("res","000");

        return result;
    }
}
