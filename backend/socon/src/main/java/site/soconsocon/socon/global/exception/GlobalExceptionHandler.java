package site.soconsocon.socon.global.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import site.soconsocon.socon.global.domain.ErrorCode;
import site.soconsocon.socon.store.exception.StoreErrorCode;
import site.soconsocon.utils.MessageUtils;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler extends CustomException {


    @ExceptionHandler(GlobalException.class)
    public ResponseEntity<Object> handleGlobalException(GlobalException e) {
        ErrorCode errorCode = e.getErrorCode();
        String errorMessage = e.getErrorMessage();

        // 400
        if(errorCode == ErrorCode.BAD_REQUEST) {
            log.error("bad request, " + ErrorCode.BAD_REQUEST.getMessage() + e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(MessageUtils.fail("" + errorCode, ErrorCode.BAD_REQUEST.getMessage() + errorMessage));
        }
        if(errorCode == ErrorCode.BAD_REQUEST_VALUE) {
            log.error("bad request value, " + ErrorCode.BAD_REQUEST_VALUE.getMessage() + e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(MessageUtils.fail("" + errorCode, ErrorCode.BAD_REQUEST_VALUE.getMessage() + errorMessage));
        }
        if(errorCode == ErrorCode.FORBIDDEN) {
            log.error("forbidden, " + ErrorCode.FORBIDDEN.getMessage() + e.getMessage());
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(MessageUtils.fail("" + errorCode, ErrorCode.FORBIDDEN.getMessage() + errorMessage));
        }

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(MessageUtils.fail("" + errorCode, ErrorCode.INTERNAL_SERVER_ERROR.getMessage()));
    }
}

