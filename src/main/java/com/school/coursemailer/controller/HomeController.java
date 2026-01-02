package com.school.coursemailer.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

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
    public String sub() {
        return "sub";
    }

    @GetMapping("/mailHistory")
    public String mailHistory() {
        return "mailHistory";
    }
}
