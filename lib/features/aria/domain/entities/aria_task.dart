import 'package:equatable/equatable.dart';

/// Task priority levels
enum TaskPriority {
  low,
  medium,
  high,
  urgent,
}

/// Task status
enum TaskStatus {
  pending,
  inProgress,
  completed,
  cancelled,
}

/// ARIA Task entity
class AriaTask extends Equatable {
  final String id;
  final String title;
  final String? description;
  final TaskPriority priority;
  final TaskStatus status;
  final DateTime? dueDate;
  final DateTime createdAt;
  final DateTime? completedAt;
  final List<String> tags;
  final String? source; // ClickUp, email, manual, etc.

  const AriaTask({
    required this.id,
    required this.title,
    this.description,
    required this.priority,
    required this.status,
    this.dueDate,
    required this.createdAt,
    this.completedAt,
    this.tags = const [],
    this.source,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        priority,
        status,
        dueDate,
        createdAt,
        completedAt,
        tags,
        source,
      ];

  AriaTask copyWith({
    String? id,
    String? title,
    String? description,
    TaskPriority? priority,
    TaskStatus? status,
    DateTime? dueDate,
    DateTime? createdAt,
    DateTime? completedAt,
    List<String>? tags,
    String? source,
  }) {
    return AriaTask(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      tags: tags ?? this.tags,
      source: source ?? this.source,
    );
  }

  /// Check if task is overdue
  bool get isOverdue {
    if (dueDate == null) return false;
    if (status == TaskStatus.completed || status == TaskStatus.cancelled) {
      return false;
    }
    return DateTime.now().isAfter(dueDate!);
  }
}
