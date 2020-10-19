class Helpers {
  static List<String> toListFromAddress(String val) => val.split('.');
  static String toAddressFromList(List<String> val) => val.join('.');

  
}
