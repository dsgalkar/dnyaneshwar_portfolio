import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../state/auth_state.dart';
import '../common/glow_button.dart';

/// Cybernetic Admin Login Dialog with credential verification
class AdminLoginDialog extends StatefulWidget {
  final AuthState authState;
  final VoidCallback onLoginSuccess;

  const AdminLoginDialog({
    super.key,
    required this.authState,
    required this.onLoginSuccess,
  });

  @override
  State<AdminLoginDialog> createState() => _AdminLoginDialogState();
}

class _AdminLoginDialogState extends State<AdminLoginDialog> {
  final TextEditingController _userController = TextEditingController(text: 'admin');
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String? _errorMessage;
  bool _isLoading = false;

  void _handleLogin() async {
    final String username = _userController.text.trim();
    final String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'Please enter both username and password/PIN');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(const Duration(milliseconds: 600));

    if (mounted) {
      final bool success = widget.authState.signIn(username, password);

      if (success) {
        Navigator.pop(context);
        widget.onLoginSuccess();
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Invalid admin credentials. Use [admin / admin] or PIN [1337]';
        });
      }
    }
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.cyan.withValues(alpha: 0.4), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cyan.withValues(alpha: 0.25),
                    blurRadius: 35,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top Lock Icon
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.cyan.withValues(alpha: 0.5),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.admin_panel_settings_rounded, color: Colors.black, size: 32),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Admin Authentication',
                    style: AppTypography.cardTitle.copyWith(fontSize: 22, color: Colors.white),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Enter master credentials to unlock the Portfolio Control Panel.',
                    style: AppTypography.bodySmall,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 24),

                  // Username field
                  TextField(
                    controller: _userController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Admin Username / Email',
                      prefixIcon: Icon(Icons.person_outline_rounded, color: AppColors.cyan, size: 20),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Password field
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Master Password or PIN',
                      prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.cyan, size: 20),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          color: AppColors.textSecondary,
                          size: 18,
                        ),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    onSubmitted: (_) => _handleLogin(),
                  ),

                  // Quick Help Hint
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Default Admin Passcode: admin / admin (or PIN: 1337)',
                      style: AppTypography.codeFont(color: AppColors.cyan.withValues(alpha: 0.8), fontSize: 11),
                    ),
                  ),

                  if (_errorMessage != null) ...[
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.error.withValues(alpha: 0.4)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 16),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _errorMessage!,
                              style: AppTypography.bodySmall.copyWith(color: AppColors.error, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 26),

                  _isLoading
                      ? const CircularProgressIndicator(color: AppColors.cyan)
                      : Row(
                          children: [
                            Expanded(
                              child: GlowButton(
                                text: 'Cancel',
                                variant: GlowButtonVariant.secondary,
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: GlowButton(
                                text: 'Authenticate',
                                variant: GlowButtonVariant.primary,
                                onPressed: _handleLogin,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
