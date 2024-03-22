package site.soconsocon.notification.email.exception;
import lombok.Getter;
import site.soconsocon.notification.fcm.exception.FcmErrorCode;

@Getter
public class FcmException extends RuntimeException {
    private final site.soconsocon.notification.fcm.exception.FcmErrorCode errorCode;

    public FcmException(FcmErrorCode errorCode) {
        super(errorCode.getMessage());
        this.errorCode = errorCode;
    }
}