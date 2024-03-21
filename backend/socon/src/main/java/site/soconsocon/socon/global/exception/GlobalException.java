package site.soconsocon.socon.global.exception;

import lombok.Getter;
import site.soconsocon.socon.global.domain.ErrorCode;

@Getter
public class GlobalException extends RuntimeException {

    private final ErrorCode errorCode;
    private final String errorMessage;

    public GlobalException(ErrorCode errorCode, String message) {
        super(errorCode.getMessage());
        this.errorCode = errorCode;
        this.errorMessage = message;
    }
}
