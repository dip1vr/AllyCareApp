import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../assessments/domain/Assessments.dart';
import 'signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  runApp(const AllyCareApp());
}

class AllyCareApp extends StatelessWidget {
  const AllyCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AllyCare Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const LoginScreen(),
    );
  }
}

void showModernSnackBar(BuildContext context, String message,
    {Color bgColor = Colors.black87, IconData? icon}) {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    backgroundColor: bgColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    content: Row(
      children: [
        if (icon != null) Icon(icon, color: Colors.white),
        if (icon != null) const SizedBox(width: 10),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ],
    ),
    duration: const Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  bool showEmail = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat();
    _rotationAnimation = Tween<double>(begin: 0, end: 360).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleContinue() async {
    if (showEmail) {
      final email = emailController.text.trim();
      if (email.isEmpty) {
        showModernSnackBar(context, "Please enter your email",
            bgColor: Colors.red, icon: Icons.error_outline);
        return;
      }
      setState(() => showEmail = false);
    } else {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        showModernSnackBar(context, "Please enter email and password",
            bgColor: Colors.red, icon: Icons.error_outline);
        return;
      }

      try {
        setState(() => isLoading = true);

        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        showModernSnackBar(context, "Welcome back 🎉",
            bgColor: Colors.green, icon: Icons.check_circle);

        Get.offAll(() => const DashboardScreen(),
        transition: Transition.fadeIn,
        duration: Duration(milliseconds: 500)
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          showModernSnackBar(context, "Account Created 🎉",
              bgColor: Colors.green, icon: Icons.check_circle);
          Get.offAll(() => const DashboardScreen(),
          );
        } else if (e.code == 'wrong-password') {
          showModernSnackBar(context, "Incorrect password ❌",
              bgColor: Colors.red, icon: Icons.error_outline);
        } else {
          showModernSnackBar(context, "Error: ${e.message} ❌",
              bgColor: Colors.red, icon: Icons.error_outline);
        }
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  void _handleBack() {
    setState(() => showEmail = true);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const Color primaryBlue = Color(0xFF1976D2);

    return Scaffold(
        resizeToAvoidBottomInset: false, 
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).padding.top + 10),

                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!showEmail)
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.grey),
                            onPressed: _handleBack,
                          ),
                        const LanguageSelector(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 80),
                  const AllyCareLogo(),
                  const SizedBox(height: 30),

                  const Text(
                    'Login or create your account',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 40),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) {
                      final offsetAnimation = Tween<Offset>(
                        begin: child.key == const ValueKey("email")
                            ? const Offset(-1, 0)
                            : const Offset(1, 0),
                        end: Offset.zero,
                      ).animate(animation);

                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        ),
                      );
                    },
                    child: showEmail
                        ? EmailInputField(
                            key: const ValueKey("email"),
                            controller: emailController,
                          )
                        : PasswordInputField(
                            key: const ValueKey("password"),
                            controller: passwordController,
                          ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _handleContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isLoading ? Colors.pink : primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: isLoading ? 3 : 5,
                        shadowColor: Colors.black.withOpacity(0.3),
                      ),
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: isLoading ? _scaleAnimation.value : 1.0,
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              child: isLoading
                                  ? Row(
                                      key: const ValueKey('loading'),
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Transform.rotate(
                                          angle: _rotationAnimation.value * 3.14159 / 180,
                                          child: Icon(
                                            Icons.sync,
                                            color: Colors.blue[600],
                                            size: 24,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Processing...',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.blue[600],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      key: const ValueKey('continue'),
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Continue',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(Icons.arrow_forward, color: Colors.white),
                                      ],
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Get.to(() => const SignupScreen(),
                      transition: Transition.fadeIn,
                      duration: Duration(milliseconds: 500),
                      );
                    },
                    child: const Text(
                      "Don't have an account? Sign up",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Stack(
  children: [
    Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: IgnorePointer( 
        child: Image.asset(
          'assets/images/group.png',
          fit: BoxFit.cover,
        ),
      ),
    ),
  ],
),


          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: SupportButton(),
            ),
          ),
        ],
      ),
    );
  }
}

class EmailInputField extends StatelessWidget {
  final TextEditingController controller;
  const EmailInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue.shade300),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          icon: Icon(Icons.alternate_email_sharp, color: Colors.grey),
          hintText: 'Enter your email',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}

class PasswordInputField extends StatelessWidget {
  final TextEditingController controller;
  const PasswordInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue.shade300),
      ),
      child: TextField(
        controller: controller,
        obscureText: true,
        decoration: const InputDecoration(
          icon: Icon(Icons.lock_outline, color: Colors.grey),
          hintText: 'Enter your password',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.flag, size: 18, color: Colors.red),
          SizedBox(width: 5),
          Text('Eng',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(width: 5),
          Icon(Icons.chevron_right, size: 18),
        ],
      ),
    );
  }
}

class AllyCareLogo extends StatelessWidget {
  const AllyCareLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      height: 60,
      fit: BoxFit.contain,
    );
  }
}

class SupportButton extends StatelessWidget {
  const SupportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.headphones_outlined,
          color: Colors.white, size: 30),
      label: const Text(
        'Support',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}