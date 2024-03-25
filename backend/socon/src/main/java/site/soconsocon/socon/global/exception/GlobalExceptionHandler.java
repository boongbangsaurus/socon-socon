package site.soconsocon.socon.global.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import site.soconsocon.socon.sogon.exception.SogonException;
import site.soconsocon.socon.store.exception.StoreException;
import site.soconsocon.utils.MessageUtils;

import java.util.Arrays;

@RestControllerAdvice
@Slf4j
public class GlobalExceptionHandler {

    @ExceptionHandler(SoconException.class)
    public ResponseEntity<Object> SoconExceptionHandler(SoconException e) {
        log.debug(Arrays.toString(e.getStackTrace()));
        return ResponseEntity.status(e.getErrorCode().getHttpStatus())
                .body(MessageUtils.fail(String.valueOf(e.getErrorCode()), e.getMessage()));

    }

    @ExceptionHandler(StoreException.class)
    public ResponseEntity<Object> StoreExceptionHandler(StoreException e) {
        log.debug(Arrays.toString(e.getStackTrace()));
        return ResponseEntity.status(e.getErrorCode().getHttpStatus())
                .body(MessageUtils.fail(String.valueOf(e.getErrorCode()), e.getMessage()));

    }

    @ExceptionHandler(SogonException.class)
    public ResponseEntity<Object> SogonExceptionHandler(SogonException e) {
        log.debug(Arrays.toString(e.getStackTrace()));
        return ResponseEntity.status(e.getErrorCode().getHttpStatus())
                .body(MessageUtils.fail(String.valueOf(e.getErrorCode()), e.getMessage()));

    }

}