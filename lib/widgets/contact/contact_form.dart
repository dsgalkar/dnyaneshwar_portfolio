import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/url_helper.dart';
import '../../data/portfolio_data.dart';
import '../../models/contact_message_model.dart';
import '../../state/portfolio_state_manager.dart';
import '../common/glass_container.dart';
import '../common/glow_button.dart';
import 'success_lottie_dialog.dart';

/// Animated Futuristic Contact Form connected to Admin Dashboard
class ContactForm extends StatefulWidget {
  final PortfolioStateManager? stateManager;

  const ContactForm({super.key, this.stateManager});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _isSubmitting = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);

      // Simulate network request
      await Future.delayed(const Duration(milliseconds: 900));

      if (mounted) {
        setState(() => _isSubmitting = false);
        final String name = _nameController.text.trim();
        final String email = _emailController.text.trim();
        final String message = _messageController.text.trim();

        // Connect directly to Admin Panel via PortfolioStateManager
        if (widget.stateManager != null) {
          widget.stateManager!.addMessage(
            ContactMessageModel(
              id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
              senderName: name.isNotEmpty ? name : 'Visitor',
              senderEmail: email,
              subject: 'Portfolio Inquiry from $name',
              message: message,
              timestamp: DateTime.now(),
              isRead: false,
            ),
          );
        }

        // Also prepare mailto
        UrlHelper.sendEmail(
          PortfolioData.email,
          subject: 'Portfolio Inquiry from $name',
          body: 'Sender Email: $email\n\n$message',
        );

        _nameController.clear();
        _emailController.clear();
        _messageController.clear();

        showDialog(
          context: context,
          barrierColor: Colors.black.withValues(alpha: 0.75),
          builder: (context) => SuccessMessageDialog(senderName: name.isNotEmpty ? name : 'Developer Friend'),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(28),
      borderRadius: 20,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send a Direct Message',
              style: AppTypography.cardTitle.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 6),
            Text(
              'Have an opportunity, collaboration idea, or question? Send me a message below.',
              style: AppTypography.bodySmall,
            ),

            const SizedBox(height: 24),

            // Name Field
            TextFormField(
              controller: _nameController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(
                labelText: 'Your Name',
                prefixIcon: Icon(Icons.person_outline_rounded, color: AppColors.primaryIndigo, size: 20),
                hintText: 'Alex Rivera',
              ),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
            ),

            const SizedBox(height: 18),

            // Email Field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(
                labelText: 'Email Address',
                prefixIcon: Icon(Icons.email_outlined, color: AppColors.primaryIndigo, size: 20),
                hintText: 'alex@example.com',
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Please enter your email';
                if (!v.contains('@') || !v.contains('.')) return 'Please enter a valid email address';
                return null;
              },
            ),

            const SizedBox(height: 18),

            // Message Field
            TextFormField(
              controller: _messageController,
              maxLines: 4,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(
                labelText: 'Your Message',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: Icon(Icons.chat_bubble_outline_rounded, color: AppColors.primaryIndigo, size: 20),
                ),
                hintText: 'Hi Dnyaneshwar, I saw your portfolio and would like to discuss...',
              ),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your message' : null,
            ),

            const SizedBox(height: 24),

            // Submit Button
            _isSubmitting
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.cyan),
                  )
                : GlowButton(
                    text: "Let's Connect",
                    icon: Icons.send_rounded,
                    width: double.infinity,
                    variant: GlowButtonVariant.primary,
                    onPressed: _submitForm,
                  ),
          ],
        ),
      ),
    );
  }
}
