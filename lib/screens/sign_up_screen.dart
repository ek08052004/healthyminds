import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import '../api/service.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final ApiService _apiService = ApiService();
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTextField(_nameController, 'Name', 'Please enter your name'),
                SizedBox(height: 16),
                _buildTextField(_usernameController, 'Username', 'Please enter your username'),
                SizedBox(height: 16),
                _buildTextField(_emailController, 'Email', 'Please enter your email', keyboardType: TextInputType.emailAddress),
                SizedBox(height: 16),
                _buildTextField(_passwordController, 'Password', 'Please enter your password', obscureText: true),
                SizedBox(height: 16),
                _buildTextField(_phoneController, 'Phone Number', 'Please enter your phone number (optional)', keyboardType: TextInputType.phone, isOptional: true),
                SizedBox(height: 16),
                _buildProfilePicPicker(),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      try {
                        final success = await _apiService.signUp(
                          name: _nameController.text,
                          username: _usernameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          phone: _phoneController.text.isNotEmpty ? _phoneController.text : null,
                          pic: _image != null ? _image!.path : null, // If it's a file path
                        );
                        if (success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomeScreen()),
                          );
                        }
                      } catch (e) {
                        print('Error: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    }
                  },
                  child: Text('Sign Up'),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text('Already have an account? Log In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String errorMessage,
      {bool obscureText = false, TextInputType keyboardType = TextInputType.text, bool isOptional = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: (value) {
        if (!isOptional && (value == null || value.isEmpty)) {
          return errorMessage;
        }
        return null;
      },
    );
  }

  Widget _buildProfilePicPicker() {
    return Column(
      children: [
        if (_image != null)
          CircleAvatar(
            radius: 50,
            backgroundImage: FileImage(_image!),
          ),
        SizedBox(height: 16),
        ElevatedButton.icon(
          icon: Icon(Icons.image),
          label: Text('Upload Profile Picture (optional)'),
          onPressed: _pickImage,
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
}
