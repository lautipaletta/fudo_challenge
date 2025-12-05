class FudoException implements Exception {
  final String message;

  FudoException({required this.message});

  @override
  String toString() {
    return message;
  }
}
