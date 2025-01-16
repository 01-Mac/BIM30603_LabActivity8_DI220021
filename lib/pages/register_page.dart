import 'package:flutter/material.dart';
import 'package:labactivity8/auth/auth_method.dart';
import 'package:labactivity8/components/my_button.dart';
import 'package:labactivity8/components/my_snackbar.dart';
import 'package:labactivity8/components/my_textfield.dart';
import 'package:labactivity8/pages/home_page.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;

  void registerUser() async {
    // Set is loading to true
    setState(() {
      isLoading = true;
    });

    // Sign up user using our AuthMethod
    String res = await AuthMethod().signupUser(
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      name: nameController.text,
    );

    // If response is success, navigate to the next screen
    if (res == "success") {
      setState(() {
        isLoading = false;
      });

      // Navigate to HomePage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });

      // Show error message
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
              size: 100,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            const SizedBox(height: 20),

            // Message / App slogan
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Let's create an account for you",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Name Textfield
            MyTextfield(
              controller: nameController,
              hintText: "Name",
              obscureText: false,
            ),
            const SizedBox(height: 20),

            // Email Textfield
            MyTextfield(
              controller: emailController,
              hintText: "Email",
              obscureText: false,
            ),
            const SizedBox(height: 20),

            // Password Textfield
            MyTextfield(
              controller: passwordController,
              hintText: "Password",
              obscureText: true,
            ),
            const SizedBox(height: 20),

            // Confirm Password Textfield
            MyTextfield(
              controller: confirmPasswordController,
              hintText: "Confirm Password",
              obscureText: true,
            ),
            const SizedBox(height: 20),

            // Register Button
            MyButton(text: "Register", onTap: registerUser),
            const SizedBox(height: 20),

            // Already have an account? Login here
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Login now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
