import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/auth_service.dart';
import 'registration_screen.dart';

class HomeScreen extends StatelessWidget {
  final Student student;

  const HomeScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService.logout();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const RegistrationScreen(),
                  ),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              student.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            _buildDetailCard('Email', student.email, Icons.email),
            _buildDetailCard('Roll Number', student.rollNumber, Icons.numbers),
            _buildDetailCard('College', student.collegeName, Icons.school),
            _buildDetailCard('State', student.state, Icons.map),
            _buildDetailCard('City', student.city, Icons.location_city),
            const SizedBox(height: 40),
            const Text(
              'Other Registered Students:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildRegisteredStudentsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String label, String value, IconData icon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildRegisteredStudentsList() {
    final students = AuthService.getAllStudents();
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: students.length,
      itemBuilder: (context, index) {
        final s = students[index];
        return ListTile(
          leading: const Icon(Icons.account_circle),
          title: Text(s.name),
          subtitle: Text(s.collegeName),
        );
      },
    );
  }
}
