package site.soconsocon.socon.sogon.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import site.soconsocon.socon.store.exception.StoreErrorCode;
import site.soconsocon.utils.MessageUtils;

@Slf4j
@ControllerAdvice
public class SogonExceptionHandler {
    @ExceptionHandler(SogonNotFoundException.class)
    public ResponseEntity<Object> handleSogonNotFoundException(SogonNotFoundException e) {
        log.error("SogonNotFoundException occurred : " + e.getMessage());
        String errorMessage = SogonErrcode.SOGON_NOT_FOUND.getMessage();
        String errorCode = SogonErrcode.SOGON_NOT_FOUND.getErrorCode();

        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(MessageUtils.fail(errorCode, errorMessage + e.getMessage()));
    }

    @ExceptionHandler(CommentNotFoundException.class)
    public ResponseEntity<Object> handleCommentNotFoundException(CommentNotFoundException e) {
        log.error("CommentNotFoundException occurred : " + e.getMessage());
        String errorMessage = SogonErrcode.COMMENT_NOT_FOUND.getMessage();
        String errorCode = SogonErrcode.COMMENT_NOT_FOUND.getErrorCode();

        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(MessageUtils.fail(errorCode, errorMessage + e.getMessage()));
    }


}
