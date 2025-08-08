class Result<T, E> {
  final T? value;
  final E? error;

  const Result._({this.value, this.error});

  factory Result.success(T value) => Result._(value: value);
  factory Result.failure(E error) => Result._(error: error);

  bool get isSuccess => value != null;
  bool get isFailure => error != null;
}

class Success<T, E> extends Result<T, E> {
  Success(T value) : super._(value: value);
}

class Failure<T, E> extends Result<T, E> {
  Failure(E error) : super._(error: error);
}