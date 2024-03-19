package site.soconsocon.socon.store.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import site.soconsocon.socon.global.domain.ErrorCode;
import site.soconsocon.socon.store.exception.ConflictException.SetClosePlanException;
import site.soconsocon.socon.store.exception.NotFoundException.RegistrationNotFoundException;
import site.soconsocon.socon.store.exception.NotFoundException.StoreNotFoundException;
import site.soconsocon.utils.MessageUtils;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(NullPointerException.class)
    public ResponseEntity<Object> handleNullPointerException(NullPointerException ex) {
        // 예외 처리
        log.error("NullPointerException occurred: {}", ex.getMessage());

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(MessageUtils.fail(ErrorCode.INTERNAL_SERVER_ERROR.getErrorCode(), ErrorCode.INTERNAL_SERVER_ERROR.getMessage()));
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
}

