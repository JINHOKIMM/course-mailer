package com.school.coursemailer.controller;

import com.school.coursemailer.service.CourseService;
import com.school.coursemailer.service.ExcelService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@RestController
@RequestMapping("/admin")
public class AdminController {

    private final CourseService courseService;
    private final ExcelService excelService;

    public AdminController(CourseService courseService, ExcelService excelService) {
        this.courseService = courseService;
        this.excelService = excelService;
    }

    @GetMapping("/courses/excel")
    public void downloadCourseListExcel(HttpServletResponse response) throws IOException {
        // Retrieve all courses (assuming selectCourseList with null userMap works for admin)
        // Note: For a robust solution, you might want a dedicated service method
        // for admin-level full course list retrieval that doesn't need userMap.
        excelService.createCourseListExcel(courseService.selectCourseList(null), response);
    }
}
