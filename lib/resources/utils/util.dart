class Util {
  static String shortenNumber(int number) {
    if (number < 1000) {
      return number.toString();
    }
    String newNumber = (number / 1000).toStringAsFixed(1);
    return "${newNumber}k";
  }
}
