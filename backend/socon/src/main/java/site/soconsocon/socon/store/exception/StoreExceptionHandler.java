package site.soconsocon.socon.store.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import site.soconsocon.socon.global.exception.CustomException;
import site.soconsocon.utils.MessageUtils;

@Slf4j
@ControllerAdvice
public class StoreExceptionHandler extends CustomException {

    @ExceptionHandler(StoreException.class)
    public ResponseEntity<Object> handleStoreException(StoreException e) {
        StoreErrorCode errorCode = e.getStoreErrorCode();
        String errorMessage = e.getErrorMessage();

        // 400
        if(errorCode == StoreErrorCode.INVALID_SOCON) {
            log.error("invalid socon, " + StoreErrorCode.INVALID_SOCON.getMessage() + e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(MessageUtils.fail("" + errorCode, StoreErrorCode.INVALID_SOCON.getMessage() + errorMessage));
        }
        if(errorCode == StoreErrorCode.ALREADY_SAVED_STORE) {
            log.error("already saved store, " + StoreErrorCode.ALREADY_SAVED_STORE.getMessage() + e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(MessageUtils.fail("" + errorCode, StoreErrorCode.ALREADY_SAVED_STORE.getMessage() + errorMessage));
        }
        if(errorCode == StoreErrorCode.ALREADY_SAVED_REGISTRATION_NUMBER) {
            log.error("already saved registration number, " + StoreErrorCode.ALREADY_SAVED_REGISTRATION_NUMBER.getMessage() + e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(MessageUtils.fail("" + errorCode, StoreErrorCode.ALREADY_SAVED_REGISTRATION_NUMBER.getMessage() + errorMessage));
        }
        if(errorCode == StoreErrorCode.ALREADY_SET_CLOSE_PLAN) {
            log.error("already set close plan, " + StoreErrorCode.ALREADY_SET_CLOSE_PLAN.getMessage() + e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(MessageUtils.fail("" + errorCode, StoreErrorCode.ALREADY_SET_CLOSE_PLAN.getMessage() + errorMessage));
        }

        // 404
        if(errorCode == StoreErrorCode.STORE_NOT_FOUND) {
            log.error("store not found, " + StoreErrorCode.STORE_NOT_FOUND.getMessage() + e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(MessageUtils.fail("" + errorCode, StoreErrorCode.STORE_NOT_FOUND.getMessage() + errorMessage));
        }

        if(errorCode == StoreErrorCode.ITEM_NOT_FOUND) {
            log.error("item not found, " + StoreErrorCode.ITEM_NOT_FOUND.getMessage() + e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(MessageUtils.fail("" + errorCode, StoreErrorCode.ITEM_NOT_FOUND.getMessage() + errorMessage));
        }
        if(errorCode == StoreErrorCode.ISSUE_NOT_FOUND) {
            log.error("issue not found, " + StoreErrorCode.ISSUE_NOT_FOUND.getMessage() + e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(MessageUtils.fail("" + errorCode, StoreErrorCode.ISSUE_NOT_FOUND.getMessage() + errorMessage));
        }
        if(errorCode == StoreErrorCode.SOCON_NOT_FOUND) {
            log.error("socon not found, " + StoreErrorCode.SOCON_NOT_FOUND.getMessage() + e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(MessageUtils.fail("" + errorCode, StoreErrorCode.SOCON_NOT_FOUND.getMessage() + errorMessage));
        }
        if(errorCode == StoreErrorCode.REGISTRATION_NUMBER_NOT_FOUND) {
            log.error("registration number not found, " + StoreErrorCode.REGISTRATION_NUMBER_NOT_FOUND.getMessage() + e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(MessageUtils.fail("" + errorCode, StoreErrorCode.REGISTRATION_NUMBER_NOT_FOUND.getMessage() + errorMessage));
        }



        return null;
    }


}
