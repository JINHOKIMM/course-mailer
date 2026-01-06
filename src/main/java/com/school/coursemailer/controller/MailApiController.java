package com.school.coursemailer.controller;

import com.school.coursemailer.service.MailService;
import com.school.coursemailer.service.StudentService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/mail")
public class MailApiController {
    private final MailService mailService;
    private final StudentService studentService;
    private static final Logger log = LoggerFactory.getLogger(MailApiController.class);
    public MailApiController(MailService mailService, StudentService studentService) {
        this.mailService = mailService;
        this.studentService = studentService;
    }

    private Map<String,Object> requireLogin(OAuth2User user) {
        if (user == null) {
            log.info("=== 로그인 x ===");
            throw new UnauthorizedException();
        }
        Map<String,Object> userMap = new HashMap<>();
        userMap = studentService.selectUserMap(getSub(user));
        return userMap;
    }

    private String getSub(OAuth2User user) {
        return user.getAttribute("sub");
    }


    @PostMapping("/send")
    public ResponseEntity<?> mailSend(@AuthenticationPrincipal OAuth2User user, @RequestParam  Map<String, Object> body) {
        Map<String,Object> userMap = requireLogin(user);

        mailService.mailSend(userMap,body);

        return ResponseEntity.ok(
                Map.of("success", true)
        );
    }

    @GetMapping("/history")
    public ResponseEntity<?> selectMailHistory(@AuthenticationPrincipal OAuth2User user) {
        Map<String,Object> userMap = requireLogin(user);
        //String email = user.getAttribute("email");

        return ResponseEntity.ok(
                mailService.selectMailHistory(userMap)
        );
    }

    @PostMapping("/graduateMailSend")
    public ResponseEntity<?> graduateMailSend(@AuthenticationPrincipal OAuth2User user) {
        Map<String,Object> userMap = requireLogin(user);

        mailService.graduateMailSend(userMap);

        return ResponseEntity.ok(
                Map.of("success", true)
        );
    }
}
