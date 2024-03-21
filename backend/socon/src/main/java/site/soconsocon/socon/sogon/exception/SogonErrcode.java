package site.soconsocon.socon.sogon.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@AllArgsConstructor
@Getter
public enum SogonErrcode {


    SOGON_NOT_FOUND(HttpStatus.NOT_FOUND, "404 SOGON_NOT_FOUND", "존재하지 않는 소곤 ID : "),
    COMMENT_NOT_FOUND(HttpStatus.NOT_FOUND, "404 COMMENT_NOT_FOUND", "존재하지 않는 댓글 ID : "),

            ;


    private final HttpStatus httpStatus;
    private final String errorCode;
    private final String message;
}
