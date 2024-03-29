import 'package:intl/intl.dart';

class StringAndDateUtils {
  static String extractWithoutHyphen(String text) {
    String extractedText = text.replaceAll("-", "");
    return extractedText;
  }

  static String getToday(){
    DateTime today = DateTime.now();
    String formattedToday = DateFormat("yyyy-MM-dd").format(today);
    return formattedToday;
  }
}

