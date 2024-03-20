package site.soconsocon.socon.global.exception.conflict;

import lombok.AllArgsConstructor;
import lombok.Getter;
import site.soconsocon.socon.global.exception.CustomException;

@AllArgsConstructor
@Getter
public class SetClosePlanException extends CustomException {

    public SetClosePlanException(String message) {
        super(message);
    }
}
