import 'package:eduwrite/widgets/header_bar.dart';
import 'package:eduwrite/widgets/promo_banner.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_code_picker/country_code_picker.dart';

import '../../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '', email = '', password = '', phone = '', countryCode = '+88';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Column(
        children: [
          const PromoBanner(),
          HeaderBar(enableLogin : false),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Heading
                          Text(
                            'Create Account',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(height: 24),

                          // Full Name
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (v) => name = v ?? '',
                            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 16),

                          // Email
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (v) => email = v ?? '',
                            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 16),

                          // Password
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (v) => password = v ?? '',
                            validator: (v) => v == null || v.length < 6 ? 'Min 6 characters' : null,
                          ),
                          const SizedBox(height: 16),

                          // Phone with country code
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CountryCodePicker(
                                onChanged: (c) => countryCode = c.dialCode ?? '+88',
                                initialSelection: 'BD',
                                favorite: const ['+88', '+91'],
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    labelText: 'Phone (without code)',
                                    border: OutlineInputBorder(),
                                  ),
                                  onSaved: (v) => phone = v ?? '',
                                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Signup button
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: loading
                                  ? null
                                  : () async {
                                if (!_formKey.currentState!.validate()) return;
                                _formKey.currentState!.save();
                                setState(() => loading = true);
                                try {
                                  final fullPhone = '$countryCode$phone';
                                  await auth.signUpWithEmail(
                                    name: name,
                                    email: email,
                                    password: password,
                                    phone: fullPhone,
                                  );
                                  Navigator.pop(context); // Go back to login
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Signup failed: $e')),
                                  );
                                } finally {
                                  setState(() => loading = false);
                                }
                              },
                              child: loading
                                  ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                                  : const Text('Create Account'),
                            ),
                          ),

                          const SizedBox(height: 16),


                          RichText(
                            text: TextSpan(
                              text: "Already have an account? ",
                              style: const TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: 'Login',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap =  () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
