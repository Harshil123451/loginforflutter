import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'welcome_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final String email;
  final String phone;
  final String gender;
  final List<String> hobbies;
  final List<String> skills;

  const ProfileScreen({
    Key? key,
    required this.username,
    required this.email,
    this.phone = '',
    this.gender = '',
    this.hobbies = const [],
    this.skills = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade300,
              Colors.blue.shade600,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Profile Content
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Profile Picture
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.shade100,
                          border: Border.all(
                            color: Colors.blue,
                            width: 3,
                          ),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // User Information Cards
                      _buildInfoCard(
                        icon: Icons.person,
                        title: 'Name',
                        value: username,
                      ),
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        icon: Icons.email,
                        title: 'Email',
                        value: email,
                      ),
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        icon: Icons.phone,
                        title: 'Phone',
                        value: phone.isEmpty ? 'Not provided' : phone,
                      ),

                      if (gender.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        _buildInfoCard(
                          icon: Icons.person_outline,
                          title: 'Gender',
                          value: gender,
                        ),
                      ],

                      if (hobbies.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        const Text(
                          'Hobbies',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: hobbies.map((hobby) {
                            return Chip(
                              label: Text(hobby),
                              backgroundColor: Colors.blue.shade100,
                            );
                          }).toList(),
                        ),
                      ],

                      if (skills.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        const Text(
                          'Skills',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: skills.map((skill) {
                            return Chip(
                              label: Text(skill),
                              backgroundColor: Colors.blue.shade100,
                            );
                          }).toList(),
                        ),
                      ],

                      const Spacer(),
                      // Edit Profile Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfileScreen(
                                  username: username,
                                  email: email,
                                  phone: phone,
                                  gender: gender,
                                  hobbies: hobbies,
                                  skills: skills,
                                ),
                              ),
                            );
                            
                            if (result != null && context.mounted) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WelcomeScreen(
                                    username: result['username'],
                                    email: result['email'],
                                    phone: result['phone'],
                                    gender: result['gender'],
                                    hobbies: List<String>.from(result['hobbies']),
                                    skills: List<String>.from(result['skills']),
                                  ),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 