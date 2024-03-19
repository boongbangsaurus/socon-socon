package site.soconsocon.socon.global.exception.notfound;

import site.soconsocon.socon.global.exception.CustomException;

public class IssueNotFoundException extends CustomException {

    public IssueNotFoundException(String message) {
        super(message);
    }
}
