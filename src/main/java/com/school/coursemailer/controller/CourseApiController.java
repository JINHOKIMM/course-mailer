package com.school.coursemailer.controller;

import com.school.coursemailer.service.CourseService;
import com.school.coursemailer.service.StudentService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
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

    // =========================
    // 공통 로그인 체크 메서드
    // =========================
    private Map<String,String> requireLogin(OAuth2User user) {
        if (user == null) {
            log.info("=== 로그인 x ===");
            throw new UnauthorizedException();
        }
        Map<String,String> userMap = new HashMap<>();
        userMap = studentService.selectUserMap(getSub(user));
        return userMap;
    }

    private String getSub(OAuth2User user) {
        return user.getAttribute("sub");
    }


    @GetMapping("/courseList")
    public ResponseEntity<?> selectCourseList(@AuthenticationPrincipal OAuth2User user) {
        log.info("=== 메인화면 List 가져오기  ===");
        Map<String,String> userMap = requireLogin(user);

        // 비즈니스 로직은 서비스로
        return ResponseEntity.ok(
                courseService.selectCourseList(userMap)
        );
    }

    @GetMapping("/myCourse")
    public ResponseEntity<?> selectMyCourse(@AuthenticationPrincipal OAuth2User user) {
        Map<String,String> userMap = requireLogin(user);

        // 비즈니스 로직은 서비스로
        return ResponseEntity.ok(
                courseService.selectMyCourse(userMap)
        );
    }

    @PostMapping("/myCourse")
    public ResponseEntity<?> updateMyCourse(@AuthenticationPrincipal OAuth2User user, @RequestBody Map<String, Object> body) {
        Map<String,String> userMap = requireLogin(user);

        courseService.updateMyCourse(userMap, body);
        return ResponseEntity.ok().build();
    }

}
