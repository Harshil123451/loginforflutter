import 'package:flutter/material.dart';
import 'change_password_screen.dart';
import 'edit_profile_screen.dart';
import 'models/app_language.dart';
import 'package:provider/provider.dart';
import 'providers/language_provider.dart';
import 'l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'John Doe';
  String _email = 'john.doe@example.com';
  String _phone = '+1 234 567 890';
  String _selectedLanguage = 'en';

  @override
  void initState() {
    super.initState();
    // Initialize selected language from provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<LanguageProvider>(context, listen: false);
      setState(() {
        _selectedLanguage = provider.currentLocale.languageCode;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).profile),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editProfile,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildProfileDetails(context),
          ],
        ),
      ),
    );
  }

  Future<void> _editProfile() async {
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          currentName: _name,
          currentEmail: _email,
          currentPhone: _phone,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _name = result['name']!;
        _email = result['email']!;
        _phone = result['phone']!;
      });
    }
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.shade100,
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: const Icon(
              Icons.person,
              size: 80,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _email,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('Personal Information', [
            _buildDetailTile('Full Name', _name),
            _buildDetailTile('Email', _email),
            _buildDetailTile('Phone', _phone),
          ]),
          const SizedBox(height: 20),
          _buildSection('Account Settings', [
            _buildActionTile('Change Password', Icons.lock, context),
            _buildActionTile('Language', Icons.language, context),
            _buildActionTile('Notifications', Icons.notifications, context),
            _buildActionTile('Privacy Settings', Icons.privacy_tip, context),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 2,
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildDetailTile(String title, String value) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildActionTile(String title, IconData icon, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: title == 'Language'
          ? Text(
              supportedLanguages
                  .firstWhere((lang) => lang.code == _selectedLanguage)
                  .nativeName,
              style: TextStyle(color: Colors.grey[600]),
            )
          : const Icon(Icons.chevron_right),
      onTap: () {
        if (title == 'Change Password') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
          );
        } else if (title == 'Language') {
          _showLanguageDialog();
        }
        // TODO: Implement other actions
      },
    );
  }

  void _showLanguageDialog() {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: supportedLanguages.map((language) {
              return RadioListTile<String>(
                title: Text(language.name),
                subtitle: Text(language.nativeName),
                value: language.code,
                groupValue: _selectedLanguage,
                onChanged: (value) async {
                  if (value != null) {
                    await languageProvider.changeLanguage(value);
                    setState(() {
                      _selectedLanguage = value;
                    });
                    if (mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Language changed to ${language.name}'),
                        ),
                      );
                    }
                  }
                },
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
} 