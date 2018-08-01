package com.biz.lesson.exception;

public class BusinessException extends RuntimeException {

    private static final long serialVersionUID = 4307931459003469552L;

    public BusinessException(String message) {
        super(message);
    }

    public BusinessException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }

    public BusinessException(String message, Throwable cause) {
        super(message, cause);
    }

    public BusinessException(Throwable cause) {
        super(cause);
    }

}
