class Response<T> {
  Status? status;
  T? data;
  String? message;

  Response.initial() : status = Status.INITIAL;
  Response.loading(this.message) : status = Status.LOADING;
  Response.succeed(this.data) : status = Status.SUCCEED;
  Response.error(this.message) : status = Status.ERROR;
}

enum Status { LOADING, SUCCEED, ERROR, INITIAL }