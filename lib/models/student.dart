import 'package:hive/hive.dart';

part 'student.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final String rollNumber;

  @HiveField(4)
  final String collegeName;

  @HiveField(5)
  final String state;

  @HiveField(6)
  final String city;

  Student({
    required this.name,
    required this.email,
    required this.password,
    required this.rollNumber,
    required this.collegeName,
    required this.state,
    required this.city,
  });
}
