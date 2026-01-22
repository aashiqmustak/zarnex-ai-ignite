import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/auth_service.dart';
import 'registration_screen.dart';

class ProfileScreen extends StatelessWidget {
  final Student student;

  const ProfileScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
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
            Stack(
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, size: 70, color: Colors.white),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4),
                      ],
                    ),
                    child: const Icon(Icons.edit, size: 20, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              student.name,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text(
              student.email,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 30),
            _buildDetailCard('Roll Number', student.rollNumber, Icons.numbers),
            _buildDetailCard('College', student.collegeName, Icons.school),
            _buildDetailCard('State', student.state, Icons.map),
            _buildDetailCard('City', student.city, Icons.location_city),
            const SizedBox(height: 40),
            const Divider(),
            const SizedBox(height: 10),
            _buildRegisteredStudentsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String label, String value, IconData icon) {
    return Card(
      elevation: 0,
      color: Colors.grey.shade50,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.blueAccent),
        ),
        title: Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 13),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildRegisteredStudentsList() {
    final students = AuthService.getAllStudents();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Other Registered Students',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: students.length,
          itemBuilder: (context, index) {
            final s = students[index];
            if (s.email == student.email) return const SizedBox.shrink();
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: Text(s.name[0].toUpperCase()),
              ),
              title: Text(
                s.name,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                s.collegeName,
                style: const TextStyle(fontSize: 12),
              ),
            );
          },
        ),
      ],
    );
  }
}
