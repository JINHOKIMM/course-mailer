package com.school.coursemailer.service;

import com.school.coursemailer.mapper.CourseMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class CourseService {
    private final CourseMapper courseMapper;

    public CourseService(CourseMapper courseMapper) {
        this.courseMapper = courseMapper;
    }

    public List<Map<String, String>> selectCourseList1() {
        return courseMapper.selectCourseList1();
    };

    public List<Map<String, String>> selectCourseList2() {
        return courseMapper.selectCourseList2();
    };

    public List<Map<String, Object>> selectMyCourse(Map<String, Object> userMap) {
        return courseMapper.selectMyCourse(userMap);
    }

    @Transactional
    public void updateMyCourse(Map<String, Object> userMap, Map<String, Object> body) {

        String studentId = String.valueOf(userMap.get("student_id"));
        String status = (String) body.get("status");

        List<Map<String, Object>> courses =
                (List<Map<String, Object>>) body.get("courses");

        // ✅ null / empty 먼저 체크
        if (courses == null || courses.isEmpty()) {
            throw new IllegalArgumentException("courses is empty or null");
        }

        courseMapper.deleteMyCourse(Map.of(
                "student_id", studentId,
                "status", status
        ));

        // 2️⃣ 선택한 과목들 insert
        for (Map<String, Object> course : courses) {
            String room = (String) course.get("room");


            course.put("student_id", studentId);
            course.put("status", status);

            course.put("room", room);

            courseMapper.insertMyCourse(course);

            log.info("insert course => {}", course);
        }
    }

    public Map<String, Object> selectMyFutureCourse(Map<String, Object> userMap) {

        List<Map<String, Object>> planned = courseMapper.selectPlanned(userMap); // O
        List<Map<String, Object>> changed = courseMapper.selectFinal(userMap);   // Y

        Map<String, Map<String, Object>> plannedMap = new HashMap<>();
        for (Map<String, Object> p : planned) {
            plannedMap.put((String) p.get("period"), p);
        }

        Map<String, Map<String, Object>> changedMap = new HashMap<>();
        for (Map<String, Object> y : changed) {
            changedMap.put((String) y.get("period"), y);
        }

        List<Map<String, Object>> finalList = new ArrayList<>();

        for (String period : List.of("A","B","C","D","E")) {
            if (changedMap.containsKey(period)) {
                finalList.add(changedMap.get(period));   // Y
            } else if (plannedMap.containsKey(period)) {
                finalList.add(plannedMap.get(period));   // O fallback
            }
        }

        return Map.of(
                "planned", planned,
                "final", finalList
        );
    }

    public List<Map<String, Object>> selectAvailableCourseList(Map<String, Object> userMap, String period) {
        userMap.put("period",period);
        return courseMapper.selectAvailableCourseList(userMap);
    }

    @Transactional
    public Map<String,String> updateMyPeriod(Map<String, Object> userMap) {
        Map<String,String> result = new HashMap<>();

        // 정원 확인 로직 (해당 과목으로 변경 가능한지)
        if(!courseMapper.isPossibleSwap(userMap)){

            result.put("res","010");
            result.put("msg", "This course is already full.");
            return result;
        }

        // 기존 course_id 가져오기
        userMap.put("status","Y");
        String course_id = courseMapper.selectCourseId(userMap);    //기존 ID
        String room = courseMapper.selectRoom(userMap);             //기존 room
        
        boolean needInsert = false;
        if(course_id == null){
            needInsert = true;
            userMap.put("status","O");
            course_id = courseMapper.selectCourseId(userMap);    //기존 ID
            room = courseMapper.selectRoom(userMap);
        }
        userMap.put("status","Y");

        Map<String,String> param = new HashMap<>();
        param.put("course_id",course_id);                           //기존 ID
        param.put("period", (String) userMap.get("period"));        //기존과 현재 period는 같음
        param.put("room",room);                                     //기존 room

        /* 기존 선택한 과목 정원 -1 */
        courseMapper.student_cntDown(param);

        /* 현재 선택한 과목 정원 +1 */
        param.put("room", (String) userMap.get("room"));            //현재 room 으로 교체
        courseMapper.student_cntUp(userMap);

        // student_course 테이블의 기존id 가져오기(시퀀스)
        String id = courseMapper.selectStudentCourseId(userMap);

        if(needInsert){
            courseMapper.insertMyCourse(userMap);
            result.put("res","000");
            return result;
        } else {
            param.put("nextCourseId", (String) userMap.get("course_id"));
            param.put("id", id);
            courseMapper.updatePeriodCourse(param);
            result.put("res","000");
            return result;
        }

    }

    public List<Map<String, Object>> selectCourseList(Map<String, Object> userMap) {
        return courseMapper.selectCourseList();
    }

    @Transactional
    public void updateCourse(Map<String, Object> params) {
        courseMapper.insertCourseHistory(params);
        courseMapper.updateCourse(params);
    }
}
