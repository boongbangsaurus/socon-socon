class StringUtils {
  static String extractWithoutHyphen(String text) {
    String extractedText = text.replaceAll("-", "");
    return extractedText;
  }
}
