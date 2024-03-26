package site.soconsocon.auth.exception;

import lombok.Getter;

@Getter
public class MemberException extends Exception{

    private final ErrorCode errorCode;

    public MemberException(ErrorCode errorCode) {
        this.errorCode = errorCode;
    }
}
