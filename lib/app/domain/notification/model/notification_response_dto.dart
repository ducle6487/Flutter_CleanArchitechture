import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architechture/core/error/enum/client/client_exception_type.dart';
import 'package:flutter_clean_architechture/core/error/model/client_failure.dart';

class NotificationResponseDTO extends Equatable {
  final String id;
  final String? description;
  final String? title;
  final String? accessId;
  final String? notificationTypeCode;
  final bool? isSeen;
  final DateTime? createdAt;

  const NotificationResponseDTO({
    required this.id,
    this.description,
    this.title,
    this.accessId,
    this.isSeen,
    this.notificationTypeCode,
    this.createdAt,
  });

  NotificationResponseDTO.clone(NotificationResponseDTO notificationResponseDTO)
      : this(
          id: notificationResponseDTO.id,
          description: notificationResponseDTO.description,
          accessId: notificationResponseDTO.accessId,
          isSeen: notificationResponseDTO.isSeen,
          notificationTypeCode: notificationResponseDTO.notificationTypeCode,
          createdAt: notificationResponseDTO.createdAt,
        );

  @override
  List<Object?> get props => [
        id,
        description,
        title,
        accessId,
        isSeen,
        notificationTypeCode,
      ];

  /// Creates an [NotificationResponseDTO] from [json].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  factory NotificationResponseDTO.fromJson({
    required Map<String, dynamic> json,
  }) {
    try {
      return NotificationResponseDTO(
        id: json['id'],
        description: json['description']?.toString(),
        title: json['title']?.toString(),
        accessId: json['accessId'],
        notificationTypeCode: json['notificationTypeCode']?.toString(),
        isSeen: json['isSeen'],
        createdAt: DateTime.parse(json['createdAt']),
      );
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.unexpectedDataTypeException,
      );
    }
  }
}
