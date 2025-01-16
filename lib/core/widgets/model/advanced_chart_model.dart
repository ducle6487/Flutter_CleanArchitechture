import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class AdvancedDayChartModel extends Equatable {
  final AssetImage? topIcon;
  final int? value;
  final Color? columnColor;

  const AdvancedDayChartModel({
    this.topIcon,
    this.value,
    this.columnColor,
  });

  @override
  List<Object?> get props => [
        topIcon,
        value,
        columnColor,
      ];
}
