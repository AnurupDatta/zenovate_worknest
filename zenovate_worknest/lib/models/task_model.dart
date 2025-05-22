import 'package:flutter/material.dart';

enum TaskStatus { todo, inProgress, done }
enum TaskPriority { low, medium, high }

class Task {
  final String id;
  final String title;
  final String description;
  final String assignedTo;
  final String assignedBy;
  final DateTime dueDate;
  final DateTime createdAt;
  final TaskStatus status;
  final TaskPriority priority;
  final List<String>? attachments;
  final List<String>? comments;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.assignedTo,
    required this.assignedBy,
    required this.dueDate,
    required this.createdAt,
    required this.status,
    required this.priority,
    this.attachments,
    this.comments,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      assignedTo: json['assignedTo'],
      assignedBy: json['assignedBy'],
      dueDate: DateTime.parse(json['dueDate']),
      createdAt: DateTime.parse(json['createdAt']),
      status: TaskStatus.values.firstWhere((e) => e.toString() == json['status']),
      priority: TaskPriority.values.firstWhere((e) => e.toString() == json['priority']),
      attachments: json['attachments'] != null ? List<String>.from(json['attachments']) : null,
      comments: json['comments'] != null ? List<String>.from(json['comments']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'assignedTo': assignedTo,
      'assignedBy': assignedBy,
      'dueDate': dueDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'status': status.toString(),
      'priority': priority.toString(),
      'attachments': attachments,
      'comments': comments,
    };
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? assignedTo,
    String? assignedBy,
    DateTime? dueDate,
    DateTime? createdAt,
    TaskStatus? status,
    TaskPriority? priority,
    List<String>? attachments,
    List<String>? comments,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      assignedTo: assignedTo ?? this.assignedTo,
      assignedBy: assignedBy ?? this.assignedBy,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      attachments: attachments ?? this.attachments,
      comments: comments ?? this.comments,
    );
  }
} 