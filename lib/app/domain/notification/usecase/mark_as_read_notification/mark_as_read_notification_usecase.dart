abstract interface class MarkAsReadNotificationUsecase {
  Future<void> execute({
    required String notificationId,
  });
}
