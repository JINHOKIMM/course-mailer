package com.school.coursemailer.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String root() {
        return "redirect:/login"; // 또는 redirect:/courses
    }

    @GetMapping("/login")
    public String login() {
        return "login"; // /WEB-INF/views/login.jsp
    }

    @GetMapping("/course")
    public String course() {
        return "course"; // /WEB-INF/views/login.jsp
    }
}
