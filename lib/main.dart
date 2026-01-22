import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/student.dart';
import 'screens/registration_screen.dart';
import 'screens/main_screen.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Adapter
  Hive.registerAdapter(StudentAdapter());

  // Open the boxes
  await Hive.openBox<Student>(AuthService.studentBoxName);
  await Hive.openBox(AuthService.sessionBoxName);

  final initialStudent = AuthService.getCurrentStudent();

  runApp(MyApp(initialStudent: initialStudent));
}

class MyApp extends StatelessWidget {
  final Student? initialStudent;
  const MyApp({super.key, this.initialStudent});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Auth App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home:
          initialStudent != null
              ? MainScreen(student: initialStudent!)
              : const RegistrationScreen(),
    );
  }
}
