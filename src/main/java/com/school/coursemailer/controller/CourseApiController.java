package com.school.coursemailer.controller;

import com.school.coursemailer.service.CourseService;
import com.school.coursemailer.service.StudentService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/course")
public class CourseApiController {
    private final CourseService courseService;
    private final StudentService studentService;
    private static final Logger log = LoggerFactory.getLogger(CourseApiController.class);
    public CourseApiController(CourseService courseService,
                               StudentService studentService) {
        this.courseService = courseService;
        this.studentService = studentService;
    }

    @GetMapping("/courseList1")
    public ResponseEntity<?> selectCourseList1() {
        // 비즈니스 로직은 서비스로
        return ResponseEntity.ok(
                courseService.selectCourseList1()
        );
    }

    @GetMapping("/courseList2")
    public ResponseEntity<?> selectCourseList2() {
        // 비즈니스 로직은 서비스로
        return ResponseEntity.ok(
                courseService.selectCourseList2()
        );
    }

    @GetMapping("/myCourse")
    public ResponseEntity<?> selectMyCourse() {
        Map<String,Object> userMap = studentService.getAuthenticatedUserMap();

        // 비즈니스 로직은 서비스로
        return ResponseEntity.ok(
                courseService.selectMyCourse(userMap)
        );
    }

    @PostMapping("/myCourse")
    public ResponseEntity<?> updateMyCourse(@RequestBody Map<String, Object> body) {
        Map<String,Object> userMap = studentService.getAuthenticatedUserMap();

        courseService.updateMyCourse(userMap, body);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/myFutureCourse")
    public ResponseEntity<?> selectMyFutureCourse() {
        Map<String,Object> userMap = studentService.getAuthenticatedUserMap();

        // 비즈니스 로직은 서비스로
        return ResponseEntity.ok(
                courseService.selectMyFutureCourse(userMap)
        );
    }

    @GetMapping("/availableCourseList")
    public ResponseEntity<?> selectAvailableCourseList(@RequestParam String period) {
        Map<String,Object> userMap = studentService.getAuthenticatedUserMap();

        // 비즈니스 로직은 서비스로
        return ResponseEntity.ok(
                courseService.selectAvailableCourseList(userMap,period)
        );
    }

    @PutMapping("/swap")
    public ResponseEntity<?> updateMyPeriod(@RequestParam String period,
                                            @RequestParam("course_code") String courseCode,@RequestParam String room) {
        Map<String,Object> userMap = studentService.getAuthenticatedUserMap();
        userMap.put("period",period);
        userMap.put("course_code",courseCode);
        userMap.put("room",room);

        return ResponseEntity.ok(
                courseService.updateMyPeriod(userMap)
        );
    }

    @GetMapping("/list")
    public ResponseEntity<?> selectCourseList() {
        // 비즈니스 로직은 서비스로
        return ResponseEntity.ok(
                courseService.selectCourseList(null)
        );
    }
    @PostMapping("/update")
    public void updateCourse(@RequestBody Map<String, Object> params) {
        Map<String,Object> userMap = studentService.getAuthenticatedUserMap();
        params.put("student_id",userMap.get("student_id"));
        courseService.updateCourse(params);
    }

    @GetMapping("/conditions")
    public ResponseEntity<?> selectConditions() {
        return ResponseEntity.ok(
                courseService.selectConditions()
        );
    }

}
