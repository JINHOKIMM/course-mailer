package com.school.coursemailer.controller;

import com.school.coursemailer.service.CourseService;
import com.school.coursemailer.service.MailService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/mail")
public class MailApiController {
    private final MailService mailService;
    private static final Logger log = LoggerFactory.getLogger(MailApiController.class);
    public MailApiController(MailService mailService) {
        this.mailService = mailService;
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


    @PostMapping("/send")
    public ResponseEntity<?> mailSend(@AuthenticationPrincipal OAuth2User user) {
        user = requireLogin(user);
        //String email = user.getAttribute("email");

        // 메일 전송은 이메일 기준
        mailService.mailSend();

        return ResponseEntity.ok(
                Map.of("success", true)
        );
    }

}
