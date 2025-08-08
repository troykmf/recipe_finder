abstract class AppFailure {
  final String message;
  const AppFailure({required this.message});
}

class ServerFailure extends AppFailure {
  final int? statusCode;
  const ServerFailure({required String message, this.statusCode}) : super(message: message);

  @override
  String toString() => 'ServerFailure(message: $message, statusCode: $statusCode)';
}

class NetworkFailure extends AppFailure {
  const NetworkFailure({required String message}) : super(message: message);

  @override
  String toString() => 'NetworkFailure(message: $message)';
}

class NoResultsFailure extends AppFailure {
  const NoResultsFailure({required String message}) : super(message: message);

  @override
  String toString() => 'NoResultsFailure(message: $message)';
}