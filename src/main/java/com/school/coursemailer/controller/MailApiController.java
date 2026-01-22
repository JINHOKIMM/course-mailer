package com.school.coursemailer.controller;

import com.school.coursemailer.service.MailService;
import com.school.coursemailer.service.StudentService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping("/send")
    public ResponseEntity<?> mailSend(@RequestParam Map<String, Object> body) {
        Map<String,Object> userMap = studentService.getAuthenticatedUserMap();

        mailService.mailSend(userMap,body);

        return ResponseEntity.ok(
                Map.of("success", true)
        );
    }

    @GetMapping("/history")
    public ResponseEntity<?> selectMailHistory() {
        Map<String,Object> userMap = studentService.getAuthenticatedUserMap();
        //String email = user.getAttribute("email");

        return ResponseEntity.ok(
                mailService.selectMailHistory(userMap)
        );
    }

    @PostMapping("/graduateMailSend")
    public ResponseEntity<?> graduateMailSend() {
        Map<String,Object> userMap = studentService.getAuthenticatedUserMap();

        mailService.graduateMailSend(userMap);

        return ResponseEntity.ok(
                Map.of("success", true)
        );
    }
}
