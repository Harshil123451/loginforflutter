import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final String username;
  final String email;
  final String phone;
  final String gender;
  final List<String> hobbies;
  final List<String> skills;

  const EditProfileScreen({
    Key? key,
    required this.username,
    required this.email,
    required this.phone,
    this.gender = '',
    this.hobbies = const [],
    this.skills = const [],
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late String _selectedGender;
  late List<String> _selectedHobbies;
  late List<String> _selectedSkills;
  final TextEditingController _skillController = TextEditingController();

  final List<String> _availableHobbies = [
    'Reading',
    'Gaming',
    'Cooking',
    'Traveling',
    'Music',
    'Sports',
    'Photography',
    'Art',
    'Writing',
    'Dancing'
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.username);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phone);
    _selectedGender = widget.gender;
    _selectedHobbies = List.from(widget.hobbies);
    _selectedSkills = List.from(widget.skills);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade300, Colors.blue.shade600],
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
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Edit Form
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
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Basic Info Section
                          _buildSectionTitle('Basic Information'),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _nameController,
                            decoration: _buildInputDecoration('Full Name', Icons.person),
                            validator: (value) => value?.isEmpty ?? true ? 'Please enter your name' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _emailController,
                            decoration: _buildInputDecoration('Email', Icons.email),
                            validator: (value) => value?.isEmpty ?? true ? 'Please enter your email' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _phoneController,
                            decoration: _buildInputDecoration('Phone', Icons.phone),
                            validator: (value) => value?.isEmpty ?? true ? 'Please enter your phone' : null,
                          ),

                          const SizedBox(height: 24),
                          // Gender Selection
                          _buildSectionTitle('Gender'),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Male',
                                groupValue: _selectedGender,
                                onChanged: (value) => setState(() => _selectedGender = value!),
                              ),
                              const Text('Male'),
                              const SizedBox(width: 16),
                              Radio<String>(
                                value: 'Female',
                                groupValue: _selectedGender,
                                onChanged: (value) => setState(() => _selectedGender = value!),
                              ),
                              const Text('Female'),
                              const SizedBox(width: 16),
                              Radio<String>(
                                value: 'Other',
                                groupValue: _selectedGender,
                                onChanged: (value) => setState(() => _selectedGender = value!),
                              ),
                              const Text('Other'),
                            ],
                          ),

                          const SizedBox(height: 24),
                          // Hobbies Section
                          _buildSectionTitle('Hobbies'),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: _availableHobbies.map((hobby) {
                              return FilterChip(
                                label: Text(hobby),
                                selected: _selectedHobbies.contains(hobby),
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      _selectedHobbies.add(hobby);
                                    } else {
                                      _selectedHobbies.remove(hobby);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 24),
                          // Skills Section
                          _buildSectionTitle('Skills'),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _skillController,
                                  decoration: InputDecoration(
                                    hintText: 'Add a skill',
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        if (_skillController.text.isNotEmpty) {
                                          setState(() {
                                            _selectedSkills.add(_skillController.text);
                                            _skillController.clear();
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: _selectedSkills.map((skill) {
                              return Chip(
                                label: Text(skill),
                                onDeleted: () {
                                  setState(() {
                                    _selectedSkills.remove(skill);
                                  });
                                },
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 32),
                          // Save Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.pop(
                                    context,
                                    {
                                      'username': _nameController.text,
                                      'email': _emailController.text,
                                      'phone': _phoneController.text,
                                      'gender': _selectedGender,
                                      'hobbies': _selectedHobbies,
                                      'skills': _selectedSkills,
                                    },
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
                                'Save Changes',
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.blue),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _skillController.dispose();
    super.dispose();
  }
} 