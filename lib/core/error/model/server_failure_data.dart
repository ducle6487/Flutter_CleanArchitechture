class ServerFailureData {
  final int? statusCode;
  final DateTime? timeStamp;
  final String? message;

  const ServerFailureData({
    this.statusCode,
    this.timeStamp,
    this.message,
  });

  factory ServerFailureData.fromJson(Map<String, dynamic> json) {
    return ServerFailureData(
      statusCode: json['statusCode'],
      timeStamp: DateTime.parse(
        json['timestamp'],
      ),
      message: json['message'],
    );
  }

  ServerFailureData copyWith({
    int? statusCode,
    DateTime? timeStamp,
    String? message,
  }) {
    return ServerFailureData(
      statusCode: statusCode ?? this.statusCode,
      timeStamp: timeStamp ?? this.timeStamp,
      message: message ?? this.message,
    );
  }

}
