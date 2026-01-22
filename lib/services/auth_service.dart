import 'package:hive_flutter/hive_flutter.dart';
import '../models/student.dart';

class AuthService {
  static const String studentBoxName = 'studentBox';
  static const String sessionBoxName = 'sessionBox';
  static const String currentUserKey = 'currentUserEmail';

  static Future<void> saveSession(String email) async {
    final box = await Hive.openBox(sessionBoxName);
    await box.put(currentUserKey, email);
  }

  static Student? getCurrentStudent() {
    final sessionBox = Hive.box(sessionBoxName);
    final email = sessionBox.get(currentUserKey);
    if (email != null) {
      final box = Hive.box<Student>(studentBoxName);
      return box.get(email);
    }
    return null;
  }

  static Future<void> logout() async {
    final box = Hive.box(sessionBoxName);
    await box.delete(currentUserKey);
  }

  static Future<void> registerStudent(Student student) async {
    final box = Hive.box<Student>(studentBoxName);
    // For simplicity, we use email as the key
    await box.put(student.email, student);
    await saveSession(student.email);
  }

  static Student? loginStudent(String email, String password) {
    final box = Hive.box<Student>(studentBoxName);
    final student = box.get(email);
    if (student != null && student.password == password) {
      return student;
    }
    return null;
  }

  static bool isEmailRegistered(String email) {
    final box = Hive.box<Student>(studentBoxName);
    return box.containsKey(email);
  }

  static List<Student> getAllStudents() {
    final box = Hive.box<Student>(studentBoxName);
    return box.values.toList();
  }
}
