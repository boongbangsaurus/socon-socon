package site.soconsocon.socon.global.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class CustomException extends RuntimeException{
    public CustomException(String message){
        super(message);
    }

}
