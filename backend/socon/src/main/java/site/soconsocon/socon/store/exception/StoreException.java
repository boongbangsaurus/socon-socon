package site.soconsocon.socon.store.exception;

import lombok.Getter;

@Getter
public class StoreException extends RuntimeException {

    private final StoreErrorCode storeErrorCode;

    public StoreException(StoreErrorCode storeErrorCode) {
        super(storeErrorCode.getMessage());
        this.storeErrorCode = storeErrorCode;

    }

}
