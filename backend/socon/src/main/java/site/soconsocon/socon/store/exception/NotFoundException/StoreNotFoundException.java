package site.soconsocon.socon.store.exception.NotFoundException;

import site.soconsocon.socon.store.exception.CustomException;

public class StoreNotFoundException extends CustomException {
    public StoreNotFoundException(String message){
        super(message);
    }
}
