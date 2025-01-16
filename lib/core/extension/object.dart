import 'package:flutter_clean_architechture/core/error/enum/client/client_exception_type.dart';
import 'package:flutter_clean_architechture/core/error/model/client_failure.dart';

extension ToDouble on Object? {
  double? toDoubleOrNull() {
    if (this == null) return null;
    if (this is int) return (this as int).toDouble();
    if (this is double) return this as double;
    throw ClientFailure(
      stackTrace: StackTrace.current,
      thrownErrorOrException: 'Unexpected type for double value: $this',
      clientExceptionType: ClientExceptionType.unexpectedDataTypeException,
    );
  }
}
