package com.school.coursemailer.service;

import com.school.coursemailer.mapper.CourseMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
}
