package site.soconsocon.socon.store.exception;

import lombok.Getter;

@Getter
public class StoreException extends RuntimeException {

    private final StoreErrorCode storeErrorCode;
    private final String errorMessage;

    public StoreException(StoreErrorCode storeErrorCode, String message) {
        super(storeErrorCode.getMessage());
        this.storeErrorCode = storeErrorCode;
        this.errorMessage = message;
    }

}
