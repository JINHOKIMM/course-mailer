package com.school.coursemailer;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.school.coursemailer.mapper")
public class CourseMailerApplication {

	public static void main(String[] args) {
		SpringApplication.run(CourseMailerApplication.class, args);
	}

}
