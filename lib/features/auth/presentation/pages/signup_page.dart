import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/sumeport_widgets.dart';
import '../../providers/auth_provider.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});
  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose(); _emailController.dispose(); _passwordController.dispose(); _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    await ref.read(authProvider.notifier).signup(fullName: _nameController.text, email: _emailController.text, password: _passwordController.text);
    if (!mounted) return;
    final authState = ref.read(authProvider);
    if (authState.message != null) _showMessage(authState.message!);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message), behavior: SnackBarBehavior.floating));
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.status == AuthStatus.checking;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),
                    Center(child: Image.asset('assets/branding/icon/sumeport_icon.png', width: 72, height: 72)),
                    const SizedBox(height: 28),
                    const SumePortText('Create your SumePort account', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    SumePortText('Your career profile will stay with you as you grow.', style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onSurfaceVariant), textAlign: TextAlign.center),
                    const SizedBox(height: 32),
                    SumePortTextField(controller: _nameController, label: 'Full name', hint: 'Your full name', prefixIcon: Icons.person_outline, textInputAction: TextInputAction.next, enabled: !isLoading, validator: (value) => value == null || value.trim().isEmpty ? 'Please enter your name.' : value.trim().length < 2 ? 'Please enter a valid name.' : null),
                    const SizedBox(height: 16),
                    SumePortTextField(controller: _emailController, label: 'Email', hint: 'you@example.com', prefixIcon: Icons.email_outlined, keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next, enabled: !isLoading, validator: (value) { final email = value?.trim() ?? ''; if (email.isEmpty) return 'Please enter your email.'; if (!email.contains('@')) return 'Please enter a valid email.'; return null; }),
                    const SizedBox(height: 16),
                    SumePortTextField(controller: _passwordController, label: 'Password', hint: 'At least 8 characters', prefixIcon: Icons.lock_outline, obscureText: _obscurePassword, enabled: !isLoading, textInputAction: TextInputAction.next, suffixIcon: _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, onSuffixTap: isLoading ? null : () => setState(() => _obscurePassword = !_obscurePassword), validator: (value) { if (value == null || value.isEmpty) return 'Please enter a password.'; if (value.length < 8) return 'Password must be at least 8 characters.'; return null; }),
                    const SizedBox(height: 16),
                    SumePortTextField(controller: _confirmPasswordController, label: 'Confirm password', hint: 'Repeat your password', prefixIcon: Icons.lock_reset_outlined, obscureText: _obscureConfirmPassword, enabled: !isLoading, textInputAction: TextInputAction.done, onSubmitted: (_) => _signup(), suffixIcon: _obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, onSuffixTap: isLoading ? null : () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword), validator: (value) { if (value == null || value.isEmpty) return 'Please confirm your password.'; if (value != _passwordController.text) return 'Passwords do not match.'; return null; }),
                    const SizedBox(height: 24),
                    SumePortButton(label: isLoading ? 'Creating account...' : 'Create account', onPressed: isLoading ? null : _signup, isLoading: isLoading, isFullWidth: true),
                    const SizedBox(height: 24),
                    Row(children: [Expanded(child: Divider(color: Theme.of(context).dividerColor)), Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: SumePortText('or', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant))), Expanded(child: Divider(color: Theme.of(context).dividerColor))]),
                    const SizedBox(height: 24),
                    OutlinedButton.icon(onPressed: isLoading ? null : () => _showMessage('Google sign-up will be connected soon.'), icon: const Icon(Icons.g_mobiledata, size: 28), label: const Text('Continue with Google')),
                    const SizedBox(height: 28),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [SumePortText('Already have an account? ', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)), TextButton(onPressed: isLoading ? null : () => context.go('/login'), child: const Text('Sign in'))]),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
