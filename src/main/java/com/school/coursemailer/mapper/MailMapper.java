package com.school.coursemailer.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface MailMapper {

    void insertMailSeq(Map<String, Object> mailMap);

    List<Map<String, Object>> selectMailHistory(Map<String, String> userMap);
}
