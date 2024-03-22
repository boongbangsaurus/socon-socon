package site.soconsocon.socon.global.exception.notfound;

import site.soconsocon.socon.global.exception.CustomException;

public class CommentNotFoundException extends CustomException {
    public CommentNotFoundException(String message) {
        super(message);
    }
}
