package com.school.coursemailer.service;

import com.school.coursemailer.controller.UnauthorizedException;
import com.school.coursemailer.mapper.StudentMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Service
public class StudentService {
    private final StudentMapper studentMapper;

    public StudentService(StudentMapper studentMapper) {
        this.studentMapper = studentMapper;
    }

    public Map<String, Object> getAuthenticatedUserMap() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated() || !(authentication.getPrincipal() instanceof OAuth2User)) {
            throw new UnauthorizedException();
        }
        OAuth2User oauth2User = (OAuth2User) authentication.getPrincipal();
        String sub = oauth2User.getAttribute("sub");
        if (sub == null) {
            throw new UnauthorizedException();
        }
        return selectUserMap(sub);
    }

    @Transactional
    public Map<String, Object> loginOrRegister(Map<String, Object> oauthInfo) {
        String sub = (String) oauthInfo.get("sub");

        // 1. 기존 사용자 조회
        Map<String, Object> student =
                studentMapper.selectBySub(sub);

        if (student != null) {
            log.info("=== 기존에 로그인 한 유저 ===");
            return student;
        }
        // 2. 없으면 insert
        log.info("=== 처음 로그인 한 유저 ===");
        studentMapper.insertStudent(oauthInfo);

        // 3. 다시 조회해서 반환 (id 포함)
        return studentMapper.selectBySub(sub);
    }

    public void updateGrade(String sub, String grade) {
        Map<String,Object> map = new HashMap<>();
        map.put("sub",sub);
        map.put("grade",grade);
        studentMapper.updateStudent(map);
    }

    public Map<String,Object> selectUserMap(String sub) {
        Map<String,Object> map = new HashMap<>();
        return studentMapper.selectUserMap(sub);
    }

}
