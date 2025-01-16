enum StatusCode {
  ok(200),
  created(201),
  badRequest(400),
  unAuthorized(401),
  notFound(404),
  internalServerError(500),
  badGateway(502),
  unVerifyAccount(5001),
  deletedAccount(5002),
  ;

  final int code;
  const StatusCode(this.code);
}
