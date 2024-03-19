package site.soconsocon.socon.store.exception.ConflictException;

import lombok.AllArgsConstructor;
import lombok.Getter;
import site.soconsocon.socon.store.exception.CustomException;

@AllArgsConstructor
@Getter
public class SetClosePlanException extends CustomException {

    public SetClosePlanException(String message) {
        super(message);
    }
}
