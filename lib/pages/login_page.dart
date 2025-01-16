import 'package:flutter/material.dart';
import 'package:labactivity8/auth/auth_method.dart';
import 'package:labactivity8/components/my_button.dart';
import 'package:labactivity8/components/my_snackbar.dart';
import 'package:labactivity8/components/my_textfield.dart';
import 'package:labactivity8/pages/handyman_list_page.dart';
import 'package:labactivity8/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  // Login method
  void login() async {
    setState(() {
      isLoading = true;
    });

    // Login user using our auth method
    String res = await AuthMethod().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );

    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HandymanListPage(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      // Show error
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Icon(
              Icons.lock_open_rounded,
              size: 180,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            const SizedBox(height: 25),

            // Message, app slogan
            Text(
              "Handyman Database App",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(height: 20),

            // Email text field
            MyTextfield(
              controller: emailController,
              hintText: "Email",
              obscureText: false,
            ),
            const SizedBox(height: 20),

            // Password text field
            MyTextfield(
              controller: passwordController,
              hintText: "Password",
              obscureText: true,
            ),
            const SizedBox(height: 20),

            // Sign-in button
            MyButton(text: "Login", onTap: login),
            const SizedBox(height: 20),

            // Not a member? Register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Register now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
