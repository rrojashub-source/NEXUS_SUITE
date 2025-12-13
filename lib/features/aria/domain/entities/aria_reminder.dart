import 'package:equatable/equatable.dart';

/// Reminder type
enum ReminderType {
  oneTime,
  daily,
  weekly,
  monthly,
}

/// ARIA Reminder entity
class AriaReminder extends Equatable {
  final String id;
  final String title;
  final String? description;
  final DateTime remindAt;
  final ReminderType type;
  final bool isCompleted;
  final DateTime createdAt;

  const AriaReminder({
    required this.id,
    required this.title,
    this.description,
    required this.remindAt,
    required this.type,
    this.isCompleted = false,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        remindAt,
        type,
        isCompleted,
        createdAt,
      ];

  AriaReminder copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? remindAt,
    ReminderType? type,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return AriaReminder(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      remindAt: remindAt ?? this.remindAt,
      type: type ?? this.type,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
