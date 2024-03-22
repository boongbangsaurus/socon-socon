package site.soconsocon.socon.global.exception;

import jakarta.security.auth.message.AuthException;
import jdk.jshell.spi.ExecutionControl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.Arrays;

@RestControllerAdvice
@Slf4j
public class GlobalExceptionHandler {
//    @ExceptionHandler(ExecutionControl.UserException.class)
//    public ResponseEntity userExceptionHandler(ExecutionControl.UserException e){
//        log.debug(Arrays.toString(e.getStackTrace()));
//        return ResponseEntity.status(e.getErrorCode().getHttpStatus())
//                .body(MessageUtils.fail(String.valueOf(e.getErrorCode()),e.getMessage()));
//    }
//
//    @ExceptionHandler(AuthException.class)
//    public ResponseEntity authExceptionHandler(AuthException e){
//        log.debug(Arrays.toString(e.getStackTrace()));
//        return ResponseEntity.status(e.getErrorCode().getHttpStatus())
//                .body(MessageUtils.fail(String.valueOf(e.getErrorCode()),e.getMessage()));
//    }
//
//    @ExceptionHandler(JwtException.class)
//    public ResponseEntity jwtExceptionHandler(JwtException e){
//        log.debug(Arrays.toString(e.getStackTrace()));
//        return ResponseEntity.status(e.getErrorCode().getHttpStatus())
//                .body(MessageUtils.fail(String.valueOf(e.getErrorCode()),e.getMessage()));
//    }
//
//    @ExceptionHandler(CardException.class)
//    public ResponseEntity CardExceptionHandler(CardException e){
//        log.debug(Arrays.toString(e.getStackTrace()));
//        return ResponseEntity.status(e.getErrorCode().getHttpStatus())
//                .body(MessageUtils.fail(String.valueOf(e.getErrorCode()),e.getMessage()));
//    }
//
//    @ExceptionHandler(CulturalHeritageException.class)
//    public ResponseEntity CulturalHeritageExceptionHandler(CulturalHeritageException e){
//        log.debug(Arrays.toString(e.getStackTrace()));
//        return ResponseEntity.status(e.getErrorCode().getHttpStatus())
//                .body(MessageUtils.fail(String.valueOf(e.getErrorCode()),e.getMessage()));
//    }
}