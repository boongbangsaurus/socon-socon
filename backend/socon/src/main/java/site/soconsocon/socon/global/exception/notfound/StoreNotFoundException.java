package site.soconsocon.socon.global.exception.notfound;

import site.soconsocon.socon.global.exception.CustomException;

public class StoreNotFoundException extends CustomException {
    public StoreNotFoundException(String message){
        super(message);
    }
}
