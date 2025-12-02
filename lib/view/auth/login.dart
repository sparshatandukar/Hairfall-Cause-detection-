// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hairfall_app/controller/auth_controller.dart';
import 'package:http/http.dart' as http;
import '../home.dart';

void main() {
  runApp(const LoginPage());
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    testConnection();
  }

  Future<void> testConnection() async {
    try {
      final res = await http.get(Uri.parse("http://127.0.0.1:8000/"));
      print(res.body);
    } catch (e) {
      print("Connection failed: $e");
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1a2a6c), Color(0xFF1e3c72), Color(0xFF2a5298)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: const [
                    Icon(Icons.spa, size: 45, color: Colors.white),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "HairCare",
                style: GoogleFonts.pacifico(fontSize: 34, color: Colors.white),
              ),
              const SizedBox(height: 6),
              const Text(
                "Your personal hair health companion",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 25),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelColor: Colors.blue.shade900,
                  unselectedLabelColor: Colors.white,
                  tabs: const [
                    Tab(
                        child: SizedBox(
                            width: 140, child: Center(child: Text("Login")))),
                    Tab(
                        child: SizedBox(
                            width: 140, child: Center(child: Text("Sign Up")))),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildLoginForm(),
                    _buildSignupForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Login Form
  Widget _buildLoginForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _customTextField("Email Address", Icons.email, false,
              controller: emailController),
          const SizedBox(height: 18),
          _customTextField("Password", Icons.lock, true,
              controller: passwordController),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Forgot Password?",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 18),
          _primaryButton("Sign In", isLogin: true),
          const SizedBox(height: 25),
          _socialLogin(),
        ],
      ),
    );
  }

  // Signup Form
  Widget _buildSignupForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _customTextField("Full Name", Icons.person, false,
              controller: nameController),
          const SizedBox(height: 18),
          _customTextField("Email Address", Icons.email, false,
              controller: emailController),
          const SizedBox(height: 18),
          _customTextField("Password", Icons.lock, true,
              controller: passwordController),
          const SizedBox(height: 18),
          _customTextField("Confirm Password", Icons.lock, true,
              controller: confirmPasswordController),
          const SizedBox(height: 25),
          _primaryButton("Create Account", isLogin: false),
          const SizedBox(height: 25),
          _socialLogin(),
        ],
      ),
    );
  }

  // Reusable Widgets
  Widget _customTextField(String hint, IconData icon, bool isPassword,
      {TextEditingController? controller}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white24,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70, fontSize: 16),
        prefixIcon: Icon(icon, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _primaryButton(String text, {required bool isLogin}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (isLogin) {
            final result = await AuthController.login(
              emailController.text,
              passwordController.text,
            );
            if (result["success"]) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(result["message"])),
            );
          } else {
            if (passwordController.text == confirmPasswordController.text) {
              final result = await AuthController.signup(
                nameController.text,
                emailController.text,
                passwordController.text,
              );
              if (result["success"]) {
                _tabController.animateTo(0); // go to login tab
                // Clear fields after signup
                nameController.clear();
                emailController.clear();
                passwordController.clear();
                confirmPasswordController.clear();
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(result["message"])),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Passwords do not match")),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue.shade900,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _socialLogin() {
    return Column(
      children: [
        const SizedBox(height: 12),
        const Text(
          "Or continue with",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/google.png", height: 36, width: 36),
          ],
        ),
      ],
    );
  }
}
