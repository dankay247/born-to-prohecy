import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:born_to_prophecy/modals/success.dart';
import 'package:born_to_prophecy/modals/unsuccessful.dart';
import '../home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

TextEditingController _nameController = TextEditingController();
bool submitted = false;
bool hasError = false;
double inputHeight = _nameController.text.isEmpty && submitted ? 70.0 : 50.0;
bool isLoading = false;
String? _gender;

class AlreadyRegistered extends StatefulWidget {
  const AlreadyRegistered({Key? key}) : super(key: key);

  @override
  State<AlreadyRegistered> createState() => _AlreadyRegisteredState();
}

void setSystemUIModeNormal() {
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom],
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black26, // Set your desired color here
      statusBarIconBrightness:
      Brightness.dark, // Set the status bar icon color (dark or light)
    ),
  );
}

class _AlreadyRegisteredState extends State<AlreadyRegistered> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _genderController.dispose();
    _nationalityController.dispose();
    _addressController.dispose();
    _occupationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), setSystemUIModeNormal);
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background/4.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned(
                            top: 1,
                            left: 16,
                            child: GestureDetector(
                              onTap: () {
                                // Handle click to navigate to HomeScreen()
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                                );
                              },
                              child: Image.asset(
                                'assets/images/back_button.png',
                                // Replace with the actual path to your image
                                height: 60,
                                width: 100, // Adjust the size as needed
                              ),
                            ),
                          ),
                          // Add other widgets in the Stack if needed
                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                        // alignment: Alignment.center,
                        child: Container(
                          width: 460,
                          height: 380,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 0.85),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Form(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 430,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'CONFIRM PREVIOUS REGISTRATION',
                                      style: TextStyle(
                                        color: Color(0xFFDF636E),
                                        fontSize: 23,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Sofia Pro',
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Container(
                                  width: 300,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    border:
                                    Border.all(color: Colors.white, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(
                                        0XFFfefefe), // Replace with your desired color
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Please enter the phone number you\n used on your first registration.',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: 300,
                                  height: (_phoneNumberController.text.isEmpty && submitted) ||
                                      (_phoneNumberController.text.isNotEmpty &&
                                          _formKey.currentState?.validate() == false)
                                      ? 60.0
                                      : 40.0,
                                  child: TextFormField(
                                    controller: _phoneNumberController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white, // Set the background color to pure white
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10), // Set the border radius to 10 pixels
                                        borderSide: const BorderSide(
                                          color: Color.fromRGBO(212, 212, 212, 1),
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10), // Set the border radius to 10 pixels
                                        borderSide: const BorderSide(
                                          color: Color(0xFFAA0123), // Set the focused border color to #AA0123
                                          width: 1.3,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                                    ),
                                    textCapitalization: TextCapitalization.words,
                                    keyboardType: TextInputType.phone,
                                    onChanged: (value) {
                                      setState(() {
                                        // Reset the error state when the value changes
                                        submitted = false;
                                      });
                                    },
                                    validator: (value) {
                                      if (submitted && (value?.isEmpty ?? true)) {
                                        return 'Please enter your phone number';
                                      }

                                      // Validate phone number format using a regular expression pattern
                                      if (submitted && value != null && value.isNotEmpty) {
                                        final RegExp phonePattern = RegExp(r'^\+?[0-9]{8,15}$');
                                        if (!phonePattern.hasMatch(value)) {
                                          return 'Invalid phone number';
                                        }
                                      }
                                      return null;
                                    },
                                  ),
                                ),

                                const SizedBox(height: 30),
                                // Repeat the pattern for other fields...
                                Container(
                                  width: 300,
                                  height: 45,
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.47),
                                        offset: Offset(0, 4),
                                        blurRadius: 40,
                                        spreadRadius: -10,
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          submitted = true;
                                        });
                                        if (_formKey.currentState?.validate() ?? false) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await Future.delayed(const Duration(seconds: 1));
                                          setState(() {
                                            isLoading = false;
                                          });
                                          if (_formKey.currentState?.validate() ?? false) {
                                            final name = _nameController.text;
                                            final phoneNumber = _phoneNumberController.text;
                                            final gender= _gender ?? '';
                                            final nationality = _nationalityController.text;
                                            final occupation = _occupationController.text;
                                            final address = _addressController.text;
                                            final currentContext = context;
                                            try {
                                              final http.Response response = await http.post(
                                                Uri.parse(
                                                    'https://api.wowlogbook.com/api/v1/btp-canada/checkin'),
                                                headers: <String, String>{
                                                  'Content-Type':
                                                  'application/json; charset=UTF-8',
                                                },
                                                body: jsonEncode({
                                                  'name': name,
                                                  'phone': phoneNumber,
                                                  // 'nationality': nationality,
                                                  // 'address': address,
                                                  // 'occupation': occupation,
                                                }),
                                              );

                                              var decodedRes = jsonDecode(response.body);

                                              if (response.statusCode == 200) {
                                                showDialog(
                                                  context: currentContext,
                                                  builder: (BuildContext dialogContext) =>
                                                      Success(decodedRes['message']),
                                                ).then((value) {
                                                  if (currentContext != null) {
                                                    Navigator.pop(currentContext);
                                                  }
                                                });
                                              } else {
                                                showDialog(
                                                  context: currentContext,
                                                  builder: (BuildContext dialogContext) =>
                                                      Success(
                                                        decodedRes['message'],
                                                      ),
                                                );
                                              }

                                            } catch (error) {
                                              showDialog(
                                                  context: currentContext,
                                                  builder: (BuildContext dialogContext) =>
                                                      Unsuccessful(
                                                          'An error occurred during the request.',
                                                          returnToFormState: () {}));
                                            }
                                            // Remaining API request and dialog code...
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0XFFAA0123),
                                      ),
                                      child: isLoading
                                          ? const SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                          AlwaysStoppedAnimation<Color>(Color(0XFFFFFFFF)),
                                        ),
                                      )
                                          : const Text(
                                        'SUBMIT',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                const Text(
                                  'We do not share any of your information with any third parties.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'wowlogbook.com',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                        color: Color(0XFFFFFFFF),
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
