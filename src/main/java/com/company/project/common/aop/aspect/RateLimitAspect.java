package com.company.project.common.aop.aspect;

import com.company.project.common.exception.RateLimitException;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@Aspect
@Component
public class RateLimitAspect {

    private Map<String, Integer> requestCount = new HashMap<>();
    private Map<String, Long> requestTime = new HashMap<>();
    private final int MAX_REQUESTS_PER_MINUTE = 10;

    @Before("@annotation(com.company.project.common.aop.annotation.RateLimit)")
    public void rateLimit(JoinPoint joinPoint) throws RateLimitException {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        String key = username + "-" + LocalDateTime.now().toString().substring(0, 16);

        if (requestCount.containsKey(key)) {
            int count = requestCount.get(key);
            long time = requestTime.get(key);
            long now = System.currentTimeMillis();

            if (now - time < 60000) {
                if (count >= MAX_REQUESTS_PER_MINUTE) {
                    throw new RateLimitException("请求过于频繁，请稍后再试！");
                } else {
                    requestCount.put(key, count + 1);
                }
            } else {
                requestCount.put(key, 1);
                requestTime.put(key, now);
            }
        } else {
            requestCount.put(key, 1);
            requestTime.put(key, System.currentTimeMillis());
        }
    }
}