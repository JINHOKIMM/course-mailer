package com.school.coursemailer.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/student")
public class StudentApiController {

    private static final Logger log = LoggerFactory.getLogger(StudentApiController.class);

    @GetMapping("/me")
    public Object me(@AuthenticationPrincipal OAuth2User user) {

        log.info("===== OAuth2 Login User ALL ATTRIBUTES =====");

        user.getAttributes().forEach((key, value) -> {
            log.info("{} = {}", key, value);
        });

        return user.getAttributes(); // JSON으로 그대로 내려감
    }
}
