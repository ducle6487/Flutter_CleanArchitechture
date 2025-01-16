import 'package:Flutter_CleanArchitechture/core/error/enum/client/client_exception_type.dart';
import 'package:Flutter_CleanArchitechture/core/error/model/client_failure.dart';

enum HomePageType {
  firstPage,
  secondPage,
  thirdPage,
  fourthPage,
  fifthPage;

  const HomePageType();

  /// Creates a [HomePageType] from [index].
  ///
  /// Throws [ClientFailure] when an error occurs.
  static HomePageType? getHomePageTypeByIndex({required int? index}) {
    if (index == null) {
      return null;
    }

    try {
      return values.firstWhere((element) => element.index == index);
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.enumNotFoundError,
      );
    }
  }
}
