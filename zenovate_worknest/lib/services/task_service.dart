import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskService extends ChangeNotifier {
  final List<Task> _tasks = [];
  bool _isLoading = false;
  String? _error;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Get tasks by status
  List<Task> getTasksByStatus(TaskStatus status) {
    return _tasks.where((task) => task.status == status).toList();
  }

  // Get tasks assigned to a specific user
  List<Task> getTasksByUser(String userId) {
    return _tasks.where((task) => task.assignedTo == userId).toList();
  }

  // Add a new task
  Future<bool> addTask(Task task) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      _tasks.add(task);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to add task';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update task status
  Future<bool> updateTaskStatus(String taskId, TaskStatus newStatus) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
      if (taskIndex != -1) {
        final task = _tasks[taskIndex];
        _tasks[taskIndex] = task.copyWith(status: newStatus);
        _isLoading = false;
        notifyListeners();
        return true;
      }
      
      _error = 'Task not found';
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = 'Failed to update task';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Delete a task
  Future<bool> deleteTask(String taskId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      final initialLength = _tasks.length;
      _tasks.removeWhere((task) => task.id == taskId);
      
      if (_tasks.length < initialLength) {
        _isLoading = false;
        notifyListeners();
        return true;
      }
      
      _error = 'Task not found';
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = 'Failed to delete task';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Add a comment to a task
  Future<bool> addComment(String taskId, String comment) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
      if (taskIndex != -1) {
        final task = _tasks[taskIndex];
        final updatedComments = [...?task.comments, comment];
        _tasks[taskIndex] = task.copyWith(comments: updatedComments);
        _isLoading = false;
        notifyListeners();
        return true;
      }
      
      _error = 'Task not found';
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = 'Failed to add comment';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Load initial tasks (for demo purposes)
  void loadDemoTasks() {
    _tasks.addAll([
      Task(
        id: '1',
        title: 'Complete Project Documentation',
        description: 'Write comprehensive documentation for the new feature',
        assignedTo: '1',
        assignedBy: '2',
        dueDate: DateTime.now().add(const Duration(days: 3)),
        createdAt: DateTime.now(),
        status: TaskStatus.todo,
        priority: TaskPriority.high,
      ),
      Task(
        id: '2',
        title: 'Code Review',
        description: 'Review pull requests for the backend team',
        assignedTo: '2',
        assignedBy: '1',
        dueDate: DateTime.now().add(const Duration(days: 1)),
        createdAt: DateTime.now(),
        status: TaskStatus.inProgress,
        priority: TaskPriority.medium,
      ),
      Task(
        id: '3',
        title: 'Team Meeting',
        description: 'Weekly team sync-up meeting',
        assignedTo: '1',
        assignedBy: '2',
        dueDate: DateTime.now().add(const Duration(hours: 2)),
        createdAt: DateTime.now(),
        status: TaskStatus.done,
        priority: TaskPriority.low,
      ),
    ]);
    notifyListeners();
  }
} 