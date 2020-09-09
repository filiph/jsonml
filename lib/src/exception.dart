library jsonml_exception;

/// An exception that is thrown when a JSONML object has an invalid format.
class JsonMLFormatException implements Exception {
  String message;

  JsonMLFormatException(this.message);

  String toString() => "JsonMLFormatException: $message";
}
