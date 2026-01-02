package com.school.coursemailer.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/login", "/", "/css/**", "/js/**","/WEB-INF/**").permitAll()
                        .anyRequest().permitAll()
                )
                .csrf(csrf -> csrf.disable())
                .oauth2Login(oauth -> oauth
                    .loginPage("/login")        // ⭐ 네 JSP 로그인 페이지
                    .defaultSuccessUrl("/main", true)
                )

                // ⭐ 로그아웃 설정
                .logout(logout -> logout
                        .logoutUrl("/logout")                 // 로그아웃 요청 URL
                        .logoutSuccessUrl("/login")           // 로그아웃 후 이동
                        .invalidateHttpSession(true)          // 세션 무효화
                        .clearAuthentication(true)            // 인증정보 제거
                        .deleteCookies("JSESSIONID")           // 쿠키 삭제
                );
        return http.build();
    }
}
