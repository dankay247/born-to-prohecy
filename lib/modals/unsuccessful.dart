import 'package:flutter/material.dart';

import '../screens/registrations/already_registered_screen.dart';


final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _phoneNumberController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _countryController = TextEditingController();
final TextEditingController _organizationController = TextEditingController();

class Unsuccessful extends StatefulWidget {
  final String apiText;
  final VoidCallback returnToFormState;

  const Unsuccessful(this.apiText,
      {Key? key, required this.returnToFormState});

  @override
  _UnsuccessfulState createState() =>
      _UnsuccessfulState();
}

class _UnsuccessfulState extends State<Unsuccessful> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    // Start a timer and navigate back to the form after 4 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context); // Pop the dialog
      if (mounted) {
        setState(() {
          submitted = false; // Reset the submitted flag
          hasError = false; // Reset the error flag
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
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
                      Navigator.pop(context);
                      widget.returnToFormState();
                    },
                    child: const Text(
                      'Thanks',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Sofia Pro',
                          fontWeight: FontWeight.w500),
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
