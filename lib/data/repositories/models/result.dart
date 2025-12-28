sealed class Result<T> {
  final T data;
  final String? message;

  const Result(this.data, this.message);

  factory Result.success(T data) = ResultSuccess<T>;
  factory Result.failure(String message) = ResultFailure<T>;
}

final class ResultFailure<T> extends Result<T> {
  const ResultFailure(String message) : super(null as T, message);
}

final class ResultSuccess<T> extends Result<T> {
  const ResultSuccess(T data) : super(data, null);
}
