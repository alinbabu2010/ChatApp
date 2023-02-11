class Response<T> {
  final T? data;
  final String? message;

  Response({this.data, this.message});

  bool get isSuccess => data != null && message == null;

  bool get isError => message?.isNotEmpty == true && data == null;
}
