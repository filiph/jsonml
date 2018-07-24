library jsonml_exception;

class JsonMLFormatException implements Exception {
  String message;
  JsonMLFormatException(this.message);

  String toString() => "JsonMLFormatException: $message";
}
