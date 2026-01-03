sealed class Result<T> {
  const Result();

  const factory Result.success(T data) = ResultSuccess<T>;
  const factory Result.failure(String message) = ResultFailure<T>;
}

final class ResultSuccess<T> extends Result<T> {
  final T data;
  const ResultSuccess(this.data);
}

final class ResultFailure<T> extends Result<T> {
  final String message;
  const ResultFailure(this.message);
}
