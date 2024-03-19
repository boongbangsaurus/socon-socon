package site.soconsocon.socon.global.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@AllArgsConstructor
@Getter
public enum ErrorCode {

    //사용자
    USER_NOT_FOUND(HttpStatus.NOT_FOUND, "404 NOT_FOUND", "사용자를 찾을 수 없습니다."),

    // 403 FORBIDDEN
    FORBIDDEN(HttpStatus.FORBIDDEN, "403 FORBIDDEN", "해당 memberId에 허용되지 않는 요청입니다."),

    // 404 NOT FOUND
    STORE_NOT_FOUND(HttpStatus.NOT_FOUND, "404 NOT_FOUND", "존재하지 않는 점포 ID입니다."),
    ITEM_NOT_FOUND(HttpStatus.NOT_FOUND, "404 NOT_FOUND", "존재하지 않는 상품 ID입니다."),
    ISSUE_NOT_FOUND(HttpStatus.NOT_FOUND, "404 NOT_FOUND", "존재하지 않는 발행 ID입니다."),
    SOCON_NOT_FOUND(HttpStatus.NOT_FOUND, "404 NOT_FOUND", "존재하지 않는 소콘 ID입니다."),
    REGISTRATION_NUMBER_NOT_FOUND(HttpStatus.NOT_FOUND, "404 NOT_FOUND", "존재하지 않는 사업자번호 ID입니다."),

    // 406 CONFLICT
    ALREADY_SAVED_STORE(HttpStatus.CONFLICT, "406 CONFLICT", "이미 등록된 가게입니다."),
    ALREADY_SAVED_REGISTRATION_NUMBER(HttpStatus.CONFLICT, "406 CONFLICT", "이미 등록된 사업자번호입니다."),
    ALREADY_SET_CLOSE_PLAN(HttpStatus.CONFLICT, "406 CONFLICT", "이미 폐업신고 된 가게입니다."),

    ;

    private final HttpStatus httpStatus;
    private final String errorCode;
    private final String message;

}