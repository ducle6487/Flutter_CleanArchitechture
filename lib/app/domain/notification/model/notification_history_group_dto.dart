import 'package:equatable/equatable.dart';
import 'package:Flutter_CleanArchitechture/app/domain/notification/model/notification_response_dto.dart';

class NotificationHistoryGroupDTO extends Equatable {
  final String title;
  final List<NotificationResponseDTO> notifications;

  const NotificationHistoryGroupDTO({
    required this.notifications,
    required this.title,
  });

  @override
  List<Object?> get props => [
        title,
        notifications,
      ];
}
