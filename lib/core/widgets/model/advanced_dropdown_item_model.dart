import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AdvancedDropdownItemModel<T> extends Equatable {
  final IconData? icon;
  final String title;
  final T? value;

  const AdvancedDropdownItemModel({
    this.icon,
    required this.title,
    this.value,
  });

  @override
  List<Object?> get props => [icon, title, value];

  /// Creates a copy of this class.
  AdvancedDropdownItemModel copyWith({
    IconData? icon,
    String? title,
    T? value,
  }) {
    return AdvancedDropdownItemModel(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      value: value ?? this.value,
    );
  }
}
