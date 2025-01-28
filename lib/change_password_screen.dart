import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _otpSent = false;
  bool _otpVerified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).changePassword),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!_otpSent) ...[
                _buildEmailField(),
                const SizedBox(height: 20),
                _buildSendOtpButton(),
              ],
              if (_otpSent && !_otpVerified) ...[
                _buildOtpField(),
                const SizedBox(height: 20),
                _buildVerifyOtpButton(),
              ],
              if (_otpVerified) ...[
                _buildCurrentPasswordField(),
                const SizedBox(height: 16),
                _buildNewPasswordField(),
                const SizedBox(height: 16),
                _buildConfirmPasswordField(),
                const SizedBox(height: 20),
                _buildChangePasswordButton(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).email,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: const Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context).pleaseEnterYourEmail;
        }
        if (!value.contains('@')) {
          return AppLocalizations.of(context).pleaseEnterAValidEmail;
        }
        return null;
      },
    );
  }

  Widget _buildOtpField() {
    return TextFormField(
      controller: _otpController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).enterOTP,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: const Icon(Icons.lock_clock),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context).pleaseEnterOTP;
        }
        if (value.length != 6) {
          return AppLocalizations.of(context).otpMustBe6Digits;
        }
        return null;
      },
    );
  }

  Widget _buildCurrentPasswordField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).currentPassword,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: const Icon(Icons.lock),
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context).pleaseEnterCurrentPassword;
        }
        return null;
      },
    );
  }

  Widget _buildNewPasswordField() {
    return TextFormField(
      controller: _newPasswordController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).newPassword,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: const Icon(Icons.lock),
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context).pleaseEnterNewPassword;
        }
        if (value.length < 6) {
          return AppLocalizations.of(context).passwordMustBeAtLeast6Characters;
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).confirmPassword,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: const Icon(Icons.lock_outline),
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context).pleaseConfirmYourPassword;
        }
        if (value != _newPasswordController.text) {
          return AppLocalizations.of(context).passwordsDoNotMatch;
        }
        return null;
      },
    );
  }

  Widget _buildSendOtpButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _sendOtp,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: _isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(AppLocalizations.of(context).sendOTP),
    );
  }

  Widget _buildVerifyOtpButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _verifyOtp,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: _isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(AppLocalizations.of(context).verifyOTP),
    );
  }

  Widget _buildChangePasswordButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _changePassword,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: _isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(AppLocalizations.of(context).submit),
    );
  }

  void _sendOtp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement actual OTP sending logic
      await Future.delayed(const Duration(seconds: 2)); // Simulated delay
      
      setState(() {
        _otpSent = true;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP sent to your email')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send OTP. Please try again.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _verifyOtp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement actual OTP verification logic
      await Future.delayed(const Duration(seconds: 2)); // Simulated delay
      
      setState(() {
        _otpVerified = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP. Please try again.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _changePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement actual password change logic
      await Future.delayed(const Duration(seconds: 2)); // Simulated delay
      
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password changed successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to change password. Please try again.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
} 