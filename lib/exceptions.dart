class HideMeException {
  final String message;
  final StackTrace? stackTrace;

  HideMeException(this.message, [this.stackTrace]);

  String get trace => stackTrace.toString();

  @override
  String toString() {
    return message;
  }
}
