package com.school.coursemailer.controller;

import com.school.coursemailer.service.MailService;
import com.school.coursemailer.service.StudentService;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/student")
public class StudentApiController {

    private static final Logger log = LoggerFactory.getLogger(StudentApiController.class);
    private final StudentService studentService;
    private final MailService mailService;

    public StudentApiController(StudentService studentService, MailService mailService) {
        this.studentService = studentService;
        this.mailService = mailService;
    }

    @GetMapping("/test")
    public ResponseEntity<?> test(HttpServletRequest request) {

        String id = request.getParameter("id");
        String sub = request.getParameter("sub");
        // 🔥 테스트용 강제 OAuth2User 샘플 (Google OAuth2 데이터 기반)
        Map<String, Object> attributes = Map.of(
                "sub", sub,
                "name", "test",
                "given_name", "test",
                "picture", "https://lh3.googleusercontent.com/a/ACg8ocIi8JJAj-Gr0dbVrfJ5lxREZ3fey7oclNWOD0_tyA_CuOD0iw=s96-c",
                "email", id,
                "email_verified", true
        );

        OAuth2User mockUser = new DefaultOAuth2User(
                List.of(
                        new SimpleGrantedAuthority("OAUTH2_USER"),
                        new SimpleGrantedAuthority("SCOPE_https://www.googleapis.com/auth/userinfo.email"),
                        new SimpleGrantedAuthority("SCOPE_https://www.googleapis.com/auth/userinfo.profile"),
                        new SimpleGrantedAuthority("SCOPE_openid")
                ),
                attributes,
                "sub"  // Principal key
        );

        OAuth2AuthenticationToken auth = new OAuth2AuthenticationToken(mockUser, mockUser.getAuthorities(), "mock");


        // SecurityContext 생성
        SecurityContext context = SecurityContextHolder.createEmptyContext();
        context.setAuthentication(auth);

        // 세션에 저장
        request.getSession(true).setAttribute("SPRING_SECURITY_CONTEXT", context);


        return ResponseEntity.ok("");
    }


    @PostMapping("/fix20260117")
    public ResponseEntity<?> fix20260117(HttpServletRequest request) {

        SimpleMailMessage message = new SimpleMailMessage();

        String content = request.getParameter("content");
        String title = request.getParameter("title"); // "Course Change Report"

        // 1️⃣ null 또는 빈 문자열 체크
        if (content == null || content.trim().isEmpty()
                || title == null || title.trim().isEmpty()
                ) {

            throw new IllegalArgumentException("필수 파라미터(content, title, to) 중 누락된 값이 있습니다.");
        }

        message.setTo("zachariah.fromme@sjajeju.kr", "tasia.sawyer@sjajeju.kr", "gregg.shoultz@sjajeju.kr");      //받는 사람 이메일
        message.setSubject(title);                      //메일 제목
        message.setText(content);                   //내용
        message.setFrom("AddDropSjajeju <sja@gmail.com>");               //보내는사람

        // 메일전송
        mailService.sendNoLog(message);
        return ResponseEntity.ok("");
    }



    @GetMapping("/me")
    public ResponseEntity<?> me() {
        log.info("=== start 로그인 정보 확인 ===");

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated() || !(authentication.getPrincipal() instanceof OAuth2User)) {
            throw new UnauthorizedException();
        }
        OAuth2User user = (OAuth2User) authentication.getPrincipal();


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
    public ResponseEntity<?> updateGrade(@RequestParam("grade") String grade ) {
        Map<String, Object> userMap = studentService.getAuthenticatedUserMap();
        String sub = (String) userMap.get("sub");

        studentService.updateGrade(sub, grade);

        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("grade", grade);

        // ✅ ResponseEntity로 감싸서 반환
        return ResponseEntity.ok(result);
    }
}
