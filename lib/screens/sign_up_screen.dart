import 'package:flutter/material.dart';
import 'loading_screen.dart'; // Import the Loading Screen

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTextField(
                    _nameController, 'Name', 'Please enter your name'),
                SizedBox(height: 16),
                _buildTextField(_ageController, 'Age', 'Please enter your age',
                    keyboardType: TextInputType.number),
                SizedBox(height: 16),
                _buildTextField(_usernameController, 'Username',
                    'Please enter your username'),
                SizedBox(height: 16),
                _buildTextField(_passwordController, 'Password',
                    'Please enter your password',
                    obscureText: true),
                SizedBox(height: 16),
                _buildTextField(
                    _emailController, 'Email ID', 'Please enter your email',
                    keyboardType: TextInputType.emailAddress),
                SizedBox(height: 16),
                _buildTextField(_phoneController, 'Phone Number',
                    'Please enter your phone number',
                    keyboardType: TextInputType.phone),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoadingScreen()),
                      );
                    }
                  },
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, String errorMessage,
      {bool obscureText = false,
      TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        return null;
      },
    );
  }
}
