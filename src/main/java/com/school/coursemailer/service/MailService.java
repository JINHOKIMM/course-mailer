package com.school.coursemailer.service;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailService {

    private final JavaMailSender mailSender;

    public MailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void mailSend() {

        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo("kjh55514@naver.com");             //받는 사람 이메일
        message.setSubject("안내 메일");                  //메일 제목
        message.setText("다음 단계로 진행해주세요.");       //내용
        message.setFrom("SJAJeju <sja@gmail.com>");    //보내는사람

        mailSender.send(message);
    }
}
