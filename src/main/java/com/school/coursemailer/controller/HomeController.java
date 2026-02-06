package com.school.coursemailer.controller;

import com.school.coursemailer.service.StudentService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Map;


@Controller
@RequiredArgsConstructor
public class HomeController {

    private final StudentService studentService;

    @GetMapping("/")
    public String root() {
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/course")
    public String course() {
        return "course";
    }

    @GetMapping("/main")
    public String mains() {
        return "main";
    }

    @GetMapping("/sub")
    public String sub() { return "sub"; }

    @GetMapping("/mailHistory")
    public String mailHistory() {
        return "mailHistory";
    }

    @GetMapping("/admin")
    public String admin() {
        return "admin";
    }

    @GetMapping("/adminLogin")
    public String adminLogin() {
        return "adminLogin";
    }

    @GetMapping("/courseCondition")
    public String courseCondition() {
        return "courseCondition";
    }
}
