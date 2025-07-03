import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/task_model.dart';
import '../models/assessment_model.dart';

class OfficerService {
  static Future<String> _localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _localFile(String fileName) async {
    final path = await _localPath();
    return File('$path/$fileName.json');
  }

  static Future<void> saveTask(TaskModel task) async {
    final file = await _localFile('tasks');
    List<TaskModel> tasks = await loadTasks();
    tasks.add(task);
    await file.writeAsString(json.encode(tasks.map((t) => t.toJson()).toList()));
  }

  static Future<List<TaskModel>> loadTasks() async {
    try {
      final file = await _localFile('tasks');
      final contents = await file.readAsString();
      final List decoded = json.decode(contents);
      return decoded.map((t) => TaskModel.fromJson(t)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> saveAssessment(AssessmentModel assessment) async {
    final file = await _localFile('assessments');
    List<AssessmentModel> assessments = await loadAssessments();
    assessments.add(assessment);
    await file.writeAsString(json.encode(assessments.map((a) => a.toJson()).toList()));
  }

  static Future<List<AssessmentModel>> loadAssessments() async {
    try {
      final file = await _localFile('assessments');
      final contents = await file.readAsString();
      final List decoded = json.decode(contents);
      return decoded.map((a) => AssessmentModel.fromJson(a)).toList();
    } catch (e) {
      return [];
    }
  }
}