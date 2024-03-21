package site.soconsocon.socon.store.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@AllArgsConstructor
@Getter
public enum StoreErrorCode {

    // 400 BAD REQUEST
    INVALID_SOCON(HttpStatus.BAD_REQUEST, "400 INVALID_SOCON", "사용 불가능한 소콘 ID : "),
    ALREADY_SAVED_STORE(HttpStatus.BAD_REQUEST, "400 ALREADY_SAVED_STORE", "동일한 이름, 좌표, 사업자등록번호의 가게 존재. storeId : "),
    ALREADY_SAVED_REGISTRATION_NUMBER(HttpStatus.BAD_REQUEST, "400 ALREADY_SAVED_REGISTRATION_NUMBER", "이미 등록된 사업자번호. registrationNumberId : "),
    ALREADY_SET_CLOSE_PLAN(HttpStatus.BAD_REQUEST, "400 ALREADY_SET_CLOSE_PLAN", "이미 폐업신고 된 가게. storeId : "),

    // 404 NOT FOUND
    STORE_NOT_FOUND(HttpStatus.NOT_FOUND, "404 STORE_NOT_FOUND", "존재하지 않는 점포 ID : "),
    ITEM_NOT_FOUND(HttpStatus.NOT_FOUND, "404 ITEM_NOT_FOUND", "존재하지 않는 상품 ID : "),
    ISSUE_NOT_FOUND(HttpStatus.NOT_FOUND, "404 ISSUE_NOT_FOUND", "존재하지 않는 발행 ID : "),
    SOCON_NOT_FOUND(HttpStatus.NOT_FOUND, "404 SOCON_NOT_FOUND", "존재하지 않는 소콘 ID : "),
    REGISTRATION_NUMBER_NOT_FOUND(HttpStatus.NOT_FOUND, "404 REGISTRATION_NUMBER_NOT_FOUND", "존재하지 않는 사업자번호 ID : "),

    ;

    private final HttpStatus httpStatus;
    private final String errorCode;
    private final String message;

}
