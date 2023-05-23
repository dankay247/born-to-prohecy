import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/registrations/new_registration_screen.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _phoneNumberController = TextEditingController();
final TextEditingController _addressController = TextEditingController();
final TextEditingController _nationalityController = TextEditingController();
final TextEditingController _occupationController = TextEditingController();
final TextEditingController _genderController = TextEditingController();
final TextEditingController _sourceController = TextEditingController();
final _scrollController = ScrollController();

class Success extends StatefulWidget {
  final String apiText;

  const Success(this.apiText, {Key? key});

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    // Start a timer and route to the Home Screen after 4 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false,
      );
      // Reset the form by resetting the form state and clearing the controllers
      _formKey.currentState?.reset();
      _nameController.clear();
      _phoneNumberController.clear();
      _addressController.clear();
      _nationalityController.clear();
      _occupationController.clear();
      submittedRegistration = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {}, // Disable taps outside the modal
      child: AlertDialog(
        content: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 450,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Align(
                    child: Image.asset(
                      'assets/images/modal.png',
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Wrap(
                    children: [
                      Text(
                        widget.apiText,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff08705f),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0XFFFF3156),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                            (route) => false,
                      );
                      // Reset the form by resetting the form state and clearing the controllers
                      setState(() {
                        _formKey.currentState?.reset();
                        _nameController.clear();
                        _phoneNumberController.clear();
                        _addressController.clear();
                        _nationalityController.clear();
                        submittedRegistration = false;
                      });
                    },
                    child: const Text(
                      'Thanks',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
