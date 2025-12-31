package com.school.coursemailer.controller;

import com.school.coursemailer.service.CourseService;
import com.school.coursemailer.service.StudentService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/student")
public class StudentApiController {

    private static final Logger log = LoggerFactory.getLogger(StudentApiController.class);
    private final StudentService studentService;
    public StudentApiController(StudentService studentService) {
        this.studentService = studentService;
    }

    // =========================
    // 공통 로그인 체크 메서드
    // =========================
    private OAuth2User requireLogin(OAuth2User user) {
        if (user == null) {
            log.info("=== 로그인 x ===");
            throw new UnauthorizedException();
        }
        return user;
    }

    private String getSub(OAuth2User user) {
        return user.getAttribute("sub");
    }

    @GetMapping("/me")
    public ResponseEntity<?> me(@AuthenticationPrincipal OAuth2User user) {
        log.info("=== start 로그인 정보 확인 ===");

        user = requireLogin(user);


        // OAuth 정보 추출
        Map<String, Object> oauthInfo = new HashMap<>();
        oauthInfo.put("sub", user.getAttribute("sub"));
        oauthInfo.put("email", user.getAttribute("email"));
        oauthInfo.put("name", user.getAttribute("name"));
        oauthInfo.put("givenName", user.getAttribute("given_name"));
        oauthInfo.put("emailVerified", user.getAttribute("email_verified"));
        oauthInfo.put("picture", user.getAttribute("picture"));

        // 비즈니스 로직은 서비스로
        return ResponseEntity.ok(
                studentService.loginOrRegister(oauthInfo)
        );
    }

    @PutMapping("/userInfo")
    public ResponseEntity<?> updateGrade(@AuthenticationPrincipal OAuth2User user, @RequestParam("grade") String grade ) {
        user = requireLogin(user);

        studentService.updateGrade(getSub(user), grade);

        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("grade", grade);

        // ✅ ResponseEntity로 감싸서 반환
        return ResponseEntity.ok(result);
    }
}
