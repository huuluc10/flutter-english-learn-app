class ResultReturn<T> {
  int httpStatusCode;
  T? data;

  ResultReturn({required this.httpStatusCode, required this.data});
}
