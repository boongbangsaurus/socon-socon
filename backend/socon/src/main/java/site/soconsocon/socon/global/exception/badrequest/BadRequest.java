package site.soconsocon.socon.global.exception.badrequest;

import site.soconsocon.socon.global.exception.CustomException;

public class BadRequest extends CustomException {

    public BadRequest(String message) {
        super(message);
    }
}
