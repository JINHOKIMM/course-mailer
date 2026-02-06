package com.school.coursemailer.service;

import com.school.coursemailer.mapper.MailMapper;
import com.school.coursemailer.mapper.StudentMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MailService {
    private final MailMapper mailMapper;
    private final JavaMailSender mailSender;
    private final StudentMapper studentMapper;
    private static final Logger log = LoggerFactory.getLogger(MailService.class);
    public MailService(MailMapper mailMapper, JavaMailSender mailSender, StudentMapper studentMapper) {
        this.mailMapper = mailMapper;
        this.mailSender = mailSender;
        this.studentMapper = studentMapper;
    }

    public void sendNoLog(SimpleMailMessage message){
        mailSender.send(message);
    }

    @Transactional
    public void mailSend(Map<String,Object> userMap, Map<String,Object> body) {

        SimpleMailMessage message = new SimpleMailMessage();


        //message.setTo("zachariah.fromme@sjajeju.kr", "tasia.sawyer@sjajeju.kr", "gregg.shoultz@sjajeju.kr");      //받는 사람 이메일
        message.setTo("kjh55514@naver.com");      //받는 사람 이메일
        message.setSubject("Course Change Report");                      //메일 제목
        message.setText((String) body.get("content"));                   //내용
        message.setFrom("AddDropSjajeju <sja@gmail.com>");               //보내는사람

        // 메일전송
        mailSender.send(message);

        Map<String,Object> mailMap = new HashMap<>();
        mailMap.put("title",message.getSubject());
        mailMap.put("content",message.getText());
        mailMap.put("receiver_email","hs_admin@sjajeju.kr");
        mailMap.put("student_id", userMap.get("student_id"));

        // 히스토리 쌓기
        mailMapper.insertMailSeq(mailMap);
        Integer mailId = (Integer) mailMap.get("mail_id");

        Map<String,Object> map = new HashMap<>();
        map.put("last_mail_id",mailId);
        map.put("sub",userMap.get("sub"));

        // 메일발송여부 업데이트 mail_seq
        studentMapper.updateStudent(map);

    }

    public List<Map<String, Object>> selectMailHistory(Map<String,Object> userMap) {
        if (userMap.get("google_email").equals("s22270836@sjajeju.kr")
                || userMap.get("google_email").equals("jimho0419@gmail.com")
                || userMap.get("google_email").equals("sja.adddrop.hera@gmail.com")
                || userMap.get("google_email").equals("zachariah.fromme@sjajeju.kr")
                || userMap.get("google_email").equals("tasia.sawyer@sjajeju.kr")
                || userMap.get("google_email").equals("gregg.shoultz@sjajeju.kr")
        ){
            log.info("관리자계정 입니다.");
            userMap.put("admin","Y");
        }

        return mailMapper.selectMailHistory(userMap);
    }

    public void graduateMailSend(Map<String, Object> userMap) {

        Map<String,Object> gradeMap = new HashMap<>();
        gradeMap.put("sub",userMap.get("sub"));
        gradeMap.put("grade","13");
        studentMapper.updateStudent(gradeMap);

        SimpleMailMessage message = new SimpleMailMessage();
        //message.setTo("zachariah.fromme@sjajeju.kr", "tasia.sawyer@sjajeju.kr", "gregg.shoultz@sjajeju.kr");      //받는 사람 이메일
        message.setTo("kjh55514@naver.com");      //받는 사람 이메일
        message.setSubject("Add & Drop Meeting Request – Graduation Credit");                                  //메일 제목
        message.setText("This is to request a personal meeting regarding a student’s course change due to graduation credit requirements at SJA Jeju. A one-on-one meeting is required for this process.\n" +
                "\n" +
                "Student Name: ["+userMap.get("name") +"]\n" +
                "Student Email: ["+userMap.get("google_email") +"]\n" +
                "\n" +
                "Please advise on available meeting times for the above-mentioned student.\n" +
                "\n" +
                "Sincerely,\n" +
                "Hera Kim");                  //내용

        message.setFrom("AddDropSjajeju <sja@gmail.com>");                     //보내는사람

        // 메일전송
        mailSender.send(message);

        System.out.println("\"zachariah.fromme@sjajeju.kr\", \"tasia.sawyer@sjajeju.kr\", \"gregg.shoultz@sjajeju.kr\"");
        System.out.println(message.getText());



        Map<String,Object> mailMap = new HashMap<>();
        mailMap.put("title",message.getSubject());
        mailMap.put("content",message.getText());
        mailMap.put("receiver_email", "hs_admin@sjajeju.kr");
        mailMap.put("student_id", userMap.get("student_id"));

        // 히스토리 쌓기
        mailMapper.insertMailSeq(mailMap);
        Integer mailId = (Integer) mailMap.get("mail_id");

        Map<String,Object> map = new HashMap<>();
        map.put("last_mail_id",mailId);
        map.put("sub",userMap.get("sub"));

        // 메일발송여부 업데이트 mail_seq
        studentMapper.updateStudent(map);
    }
}
