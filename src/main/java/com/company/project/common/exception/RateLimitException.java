package com.company.project.common.exception;

public class RateLimitException extends RuntimeException {

    public RateLimitException(String message) {
        super(message);
    }
}