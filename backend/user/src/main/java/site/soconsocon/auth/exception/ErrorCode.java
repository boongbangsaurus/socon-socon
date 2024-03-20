package site.soconsocon.auth.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;
import site.soconsocon.utils.exception.CustomError;

@AllArgsConstructor
@Getter
public enum ErrorCode implements CustomError {

    //필터 검증 에러

    //사용자
    USER_NOT_FOUND(HttpStatus.NOT_FOUND, "404", "사용자를 찾을 수 없습니다."),

    //알람
    NO_ALARM_SET(HttpStatus.BAD_REQUEST, "400", "설정한 알람이 없습니다."),

    //FCM
    NOT_FOUND_FCM_TOKEN(HttpStatus.NOT_FOUND, "404", "FCM 토큰이 없습니다"),


    ;


    private final HttpStatus httpStatus;
    private final String errorCode;
    private final String message;

}
