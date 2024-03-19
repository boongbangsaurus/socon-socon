package site.soconsocon.auth.exception;

import lombok.Getter;

@Getter
public class JwtException extends Exception {

    private final ErrorCode code;

    public JwtException(ErrorCode code) {
        this.code = code;
    }

}
