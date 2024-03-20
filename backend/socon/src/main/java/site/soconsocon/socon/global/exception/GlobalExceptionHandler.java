package site.soconsocon.socon.global.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import site.soconsocon.socon.global.domain.ErrorCode;
import site.soconsocon.socon.global.exception.badrequest.BadRequest;
import site.soconsocon.socon.global.exception.badrequest.BadRequestValue;
import site.soconsocon.socon.global.exception.badrequest.InvalidSoconException;
import site.soconsocon.socon.global.exception.conflict.SetClosePlanException;
import site.soconsocon.socon.global.exception.notfound.IssueNotFoundException;
import site.soconsocon.socon.global.exception.notfound.RegistrationNotFoundException;
import site.soconsocon.socon.global.exception.notfound.SoconNotFoundException;
import site.soconsocon.socon.global.exception.notfound.StoreNotFoundException;
import site.soconsocon.utils.MessageUtils;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(NullPointerException.class)
    public ResponseEntity<Object> handleNullPointerException(NullPointerException ex) {
        log.error("NullPointerException occurred: {}", ex.getMessage());

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(MessageUtils.fail(ErrorCode.INTERNAL_SERVER_ERROR.getErrorCode(), ErrorCode.INTERNAL_SERVER_ERROR.getMessage()));
    }

    @ExceptionHandler(BadRequest.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ResponseEntity<Object> handleBadRequestException(BadRequest e) {
        log.error("BadRequestException occurred: " + e.getMessage());
        String errorMessage = ErrorCode.BAD_REQUEST.getMessage();
        String errorCode = ErrorCode.BAD_REQUEST.getErrorCode();

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(MessageUtils.fail(errorCode, errorMessage));
    }

    @ExceptionHandler(BadRequestValue.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ResponseEntity<Object> handleBadRequestValueException(BadRequestValue e) {
        log.error("BadRequestValueException occurred: " + e.getMessage());
        String errorMessage = ErrorCode.BAD_REQUEST_VALUE.getMessage();
        String errorCode = ErrorCode.BAD_REQUEST_VALUE.getErrorCode();

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(MessageUtils.fail(errorCode, errorMessage));
    }

    @ExceptionHandler(InvalidSoconException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ResponseEntity<Object> handleInvalidSoconException(InvalidSoconException e) {
        log.error("InvalidSoconException occurred : " + e.getMessage());
        String errorCode = ErrorCode.INVALID_SOCON.getErrorCode();

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(MessageUtils.fail(errorCode, e.getMessage()));
    }

    @ExceptionHandler(StoreDuplicationException.class)
    public ResponseEntity<Object> handleStoreDuplicationException(StoreDuplicationException e) {
        log.error("StoreDuplicationException occurred : " + e.getMessage());
        String errorMessage = ErrorCode.ALREADY_SAVED_STORE.getMessage();
        String errorCode = ErrorCode.ALREADY_SAVED_STORE.getErrorCode();

        return ResponseEntity.status(HttpStatus.CONFLICT).body(MessageUtils.fail(errorCode, errorMessage));
    }

    @ExceptionHandler(ForbiddenException.class)
    public ResponseEntity<Object> handleForbiddenException(ForbiddenException e) {
        log.error("ForbiddenException occurred : " + e.getMessage());
        String errorMessage = ErrorCode.FORBIDDEN.getMessage();
        String errorCode = ErrorCode.FORBIDDEN.getErrorCode();

        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(MessageUtils.fail(errorCode, errorMessage));
    }

    @ExceptionHandler(SetClosePlanException.class)
    public ResponseEntity<Object> handleSetClosePlanException(SetClosePlanException e) {
        log.error("SetClosePlanException occurred : " + e.getMessage());
        String errorMessage = ErrorCode.ALREADY_SET_CLOSE_PLAN.getMessage();
        String errorCode = ErrorCode.ALREADY_SET_CLOSE_PLAN.getErrorCode();

        return ResponseEntity.status(HttpStatus.CONFLICT).body(MessageUtils.fail(errorCode, errorMessage));
    }
    @ExceptionHandler(StoreNotFoundException.class)
    public ResponseEntity<Object> handleStoreNotFoundException(StoreNotFoundException e) {
        log.error("StoreNotFoundException occurred : " + e.getMessage());
        String errorMessage = ErrorCode.STORE_NOT_FOUND.getMessage();
        String errorCode = ErrorCode.STORE_NOT_FOUND.getErrorCode();

        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(MessageUtils.fail(errorCode, errorMessage));
    }

    @ExceptionHandler(RegistrationNotFoundException.class)
    public ResponseEntity<Object> handleRegistrationNotFoundException(RegistrationNotFoundException e) {
        log.error("RegistrationNotFoundException occurred : " + e.getMessage());
        String errorMessage = ErrorCode.REGISTRATION_NUMBER_NOT_FOUND.getMessage();
        String errorCode = ErrorCode.REGISTRATION_NUMBER_NOT_FOUND.getErrorCode();

        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(MessageUtils.fail(errorCode, errorMessage));
    }

    @ExceptionHandler(IssueNotFoundException.class)
    public ResponseEntity<Object> handleIssueNotFoundException(IssueNotFoundException e) {
        log.error("IssueNotFoundException occurred : " + e.getMessage());
        String errorMessage = ErrorCode.ISSUE_NOT_FOUND.getMessage();
        String errorCode = ErrorCode.ISSUE_NOT_FOUND.getErrorCode();

        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(MessageUtils.fail(errorCode, errorMessage));
    }

    @ExceptionHandler(SoconNotFoundException.class)
    public ResponseEntity<Object> handleSoconNotFoundException(SoconNotFoundException e) {
        log.error("SoconNotFoundException occurred : " + e.getMessage());
        String errorMessage = ErrorCode.SOCON_NOT_FOUND.getMessage();
        String errorCode = ErrorCode.SOCON_NOT_FOUND.getErrorCode();

        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(MessageUtils.fail(errorCode, errorMessage));
    }



}

