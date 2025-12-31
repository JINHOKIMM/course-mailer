package com.school.coursemailer.service;

import com.school.coursemailer.mapper.CourseMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CourseService {
    private final CourseMapper courseMapper;

    public CourseService(CourseMapper courseMapper) {
        this.courseMapper = courseMapper;
    }

    public List<Map<String, String>> selectCourseCond(String sub) {
        return courseMapper.selectCourseCond(sub);
    };
}
