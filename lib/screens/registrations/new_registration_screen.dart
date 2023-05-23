import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:born_to_prophecy/modals/success.dart';
import 'package:born_to_prophecy/modals/unsuccessful.dart';
import '../home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

TextEditingController _nameController = TextEditingController();
String? _gender;
String? _soi;
bool submittedRegistration = false;
bool hasError = false;
double inputHeight =
    _nameController.text.isEmpty && submittedRegistration ? 70.0 : 50.0;
bool isLoading = false;

class NewRegistration extends StatefulWidget {
  const NewRegistration({Key? key}) : super(key: key);

  @override
  State<NewRegistration> createState() => _NewRegistrationState();
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

class _NewRegistrationState extends State<NewRegistration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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
                                  MaterialPageRoute(
                                      builder: (context) => const HomeScreen()),
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
                          height: 540,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 0.85),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 420,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(
                                        0XFFFEFEFE), // Replace with your desired color
                                  ),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'REGISTER',
                                      style: TextStyle(
                                        color: Color(0xFFDF636E),
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Sofia Pro',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Full Name',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        SizedBox(
                                          width: 250,
                                          height:
                                              _nameController.text.isEmpty &&
                                                      submittedRegistration
                                                  ? 50.0
                                                  : 30.0,
                                          child: TextFormField(
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            controller: _nameController,
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                // Set the border radius to 10 pixels
                                                borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  // Set the border color to pure white
                                                  width: 2,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                // Set the border radius to 10 pixels
                                                borderSide: const BorderSide(
                                                    color: Color(0xFFAA0123),
                                                    width: 1.3),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 7),
                                              errorText:
                                                  submittedRegistration &&
                                                          _nameController
                                                              .text.isEmpty
                                                      ? 'Please enter your name'
                                                      : null,
                                              errorStyle:
                                                  const TextStyle(fontSize: 10),
                                            ),
                                            textCapitalization:
                                                TextCapitalization.words,
                                            onChanged: (value) {
                                              setState(() {
                                                submittedRegistration = false;
                                              });
                                            },
                                            validator: (value) {
                                              if (submittedRegistration &&
                                                  (value?.isEmpty ?? true)) {
                                                return 'Please enter your name';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Gender',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        SizedBox(
                                          width: 150,
                                          height: 35,
                                          child:
                                              DropdownButtonFormField<String>(
                                            value: _gender,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: 'Select Gender',
                                              hintStyle: const TextStyle(
                                                fontSize: 13,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: Color.fromRGBO(
                                                      212, 212, 212, 1),
                                                  width: 2,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFAA0123),
                                                  // Set the focused border color to #AA0123
                                                  width: 1.3,
                                                ),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 7,
                                              ),
                                              errorStyle:
                                                  const TextStyle(fontSize: 10),
                                            ),
                                            items: ['Male', 'Female']
                                                .map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _gender = newValue;
                                                submittedRegistration = false;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Phone',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        SizedBox(
                                          width: 203,
                                          height: (_phoneNumberController
                                                          .text.isEmpty &&
                                                      submittedRegistration) ||
                                                  (_phoneNumberController
                                                          .text.isNotEmpty &&
                                                      _formKey.currentState
                                                              ?.validate() ==
                                                          false)
                                              ? 50.0
                                              : 30.0,
                                          child: TextFormField(
                                            controller: _phoneNumberController,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              // Set the background color to pure white
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                // Set the border radius to 10 pixels
                                                borderSide: const BorderSide(
                                                  color: Color.fromRGBO(
                                                      212, 212, 212, 1),
                                                  width: 2,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                // Set the border radius to 10 pixels
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFAA0123),
                                                  // Set the focused border color to #AA0123
                                                  width: 1.3,
                                                ),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 7),
                                              errorText:
                                                  submittedRegistration &&
                                                          _phoneNumberController
                                                              .text.isEmpty
                                                      ? 'Please enter your name'
                                                      : null,
                                              errorStyle:
                                                  const TextStyle(fontSize: 10),
                                            ),
                                            textCapitalization:
                                                TextCapitalization.words,
                                            keyboardType: TextInputType.phone,
                                            onChanged: (value) {
                                              setState(() {
                                                // Reset the error state when the value changes
                                                submittedRegistration = false;
                                              });
                                            },
                                            validator: (value) {
                                              if (submittedRegistration &&
                                                  (value?.isEmpty ?? true)) {
                                                return 'Please enter your phone number';
                                              }

                                              // Validate phone number format using a regular expression pattern
                                              if (submittedRegistration &&
                                                  value != null &&
                                                  value.isNotEmpty) {
                                                final RegExp phonePattern =
                                                    RegExp(r'^\+?[0-9]{8,15}$');
                                                if (!phonePattern
                                                    .hasMatch(value)) {
                                                  return 'Invalid phone number';
                                                }
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Email',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        SizedBox(
                                          width: 203,
                                          height: (_phoneNumberController
                                                          .text.isEmpty &&
                                                      submittedRegistration) ||
                                                  (_phoneNumberController
                                                          .text.isNotEmpty &&
                                                      _formKey.currentState
                                                              ?.validate() ==
                                                          false)
                                              ? 50.0
                                              : 30.0,
                                          child: TextFormField(
                                            controller: _emailController,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              // Set the background color to pure white
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                // Set the border radius to 10 pixels
                                                borderSide: const BorderSide(
                                                  color: Color.fromRGBO(
                                                      212, 212, 212, 1),
                                                  width: 2,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                // Set the border radius to 10 pixels
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFAA0123),
                                                  // Set the focused border color to #AA0123
                                                  width: 1.3,
                                                ),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 7),
                                              errorText: submittedRegistration &&
                                                      _phoneNumberController
                                                          .text.isEmpty
                                                  ? 'Please enter your email'
                                                  : null,
                                              errorStyle:
                                                  const TextStyle(fontSize: 10),
                                            ),
                                            textCapitalization:
                                                TextCapitalization.none,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            onChanged: (value) {
                                              setState(() {
                                                // Reset the error state when the value changes
                                                submittedRegistration = false;
                                              });
                                            },
                                            validator: (value) {
                                              if (submittedRegistration &&
                                                  value != null &&
                                                  value.isNotEmpty) {
                                                final emailPattern = RegExp(
                                                    r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
                                                if (!emailPattern
                                                    .hasMatch(value)) {
                                                  return 'Invalid email';
                                                }
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                SizedBox(
                                  height: 35,
                                  width: 420,
                                  child: TextFormField(
                                    controller: _nationalityController,
                                    decoration: InputDecoration(
                                      hintText: 'Nationality',
                                      hintStyle: const TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      // Set the background color to pure white
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        // Set the border radius to 10 pixels
                                        borderSide: const BorderSide(
                                          color:
                                          Color.fromRGBO(212, 212, 212, 1),
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        // Set the border radius to 10 pixels
                                        borderSide: const BorderSide(
                                          color: Color(0xFFAA0123),
                                          // Set the focused border color to #AA0123
                                          width: 1.3,
                                        ),
                                      ),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 7),
                                    ),
                                    textCapitalization:
                                    TextCapitalization.words,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                SizedBox(
                                  height: 35,
                                  width: 420,
                                  child: TextFormField(
                                    controller: _addressController,
                                    decoration: InputDecoration(
                                      hintText: 'Address',
                                      hintStyle: const TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      // Set the background color to pure white
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        // Set the border radius to 10 pixels
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(212, 212, 212, 1),
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        // Set the border radius to 10 pixels
                                        borderSide: const BorderSide(
                                          color: Color(0xFFAA0123),
                                          // Set the focused border color to #AA0123
                                          width: 1.3,
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 7),
                                    ),
                                    textCapitalization:
                                        TextCapitalization.words,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                SizedBox(
                                  height: 35,
                                  width: 420,
                                  child: TextFormField(
                                    controller: _occupationController,
                                    decoration: InputDecoration(
                                      hintText: 'Occupation',
                                      hintStyle: const TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      // Set the background color to pure white
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        // Set the border radius to 10 pixels
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(212, 212, 212, 1),
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        // Set the border radius to 10 pixels
                                        borderSide: const BorderSide(
                                          color: Color(0xFFAA0123),
                                          // Set the focused border color to #AA0123
                                          width: 1.3,
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 7),
                                    ),
                                    textCapitalization:
                                        TextCapitalization.words,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                SizedBox(
                                  width: 420,
                                  height: 35,
                                  child: DropdownButtonFormField<String>(
                                    value: _soi,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Source of Information',
                                      hintStyle: const TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(212, 212, 212, 1),
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFAA0123),
                                          // Set the focused border color to #AA0123
                                          width: 1.3,
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 7,
                                      ),
                                      errorStyle: const TextStyle(fontSize: 13),
                                    ),
                                    items: [
                                      'Radio',
                                      'Flyer',
                                      'Social Media',
                                      'Word of Mouth',
                                      'TV'
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _soi = newValue;
                                        submittedRegistration = false;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 15),
                                // Repeat the pattern for other fields...
                                Container(
                                  width: 400,
                                  height: 42,
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
                                          submittedRegistration = true;
                                        });
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await Future.delayed(
                                              const Duration(seconds: 1));
                                          setState(() {
                                            isLoading = false;
                                          });
                                          if (_formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            final name = _nameController.text;
                                            final phoneNumber =
                                                _phoneNumberController.text;
                                            final nationality =
                                                _nationalityController.text;
                                            final occupation =
                                                _occupationController.text;
                                            final address =
                                                _addressController.text;
                                            final gender = _gender;
                                            final source = _soi;
                                            final currentContext = context;
                                            try {
                                              final http.Response response =
                                                  await http.post(
                                                Uri.parse(
                                                    'https://api.wowlogbook.com/api/v1/btp-canada/register'),
                                                headers: <String, String>{
                                                  'Content-Type':
                                                      'application/json; charset=UTF-8',
                                                },
                                                body: jsonEncode({
                                                  'name': name,
                                                  'phone': phoneNumber,
                                                  'gender': gender,
                                                  'occupation': occupation,
                                                  'nationality': nationality,
                                                  'location': address,
                                                  'source_of_info': source,
                                                }),
                                              );

                                              var decodedRes =
                                                  jsonDecode(response.body);

                                              if (response.statusCode == 200) {
                                                showDialog(
                                                  context: currentContext,
                                                  builder: (BuildContext
                                                          dialogContext) =>
                                                      Success(decodedRes[
                                                          'message']),
                                                ).then((value) {
                                                  // Return to the form state after dismissing the modal
                                                  Navigator.pop(currentContext);
                                                });
                                              } else {
                                                showDialog(
                                                  context: currentContext,
                                                  builder: (BuildContext
                                                          dialogContext) =>
                                                      Unsuccessful(
                                                    decodedRes['message'],
                                                    returnToFormState: () {},
                                                  ),
                                                );
                                              }
                                            } catch (error) {
                                              showDialog(
                                                  context: currentContext,
                                                  builder: (BuildContext
                                                          dialogContext) =>
                                                      Unsuccessful(
                                                          'An error occurred during the request.',
                                                          returnToFormState:
                                                              () {}));
                                            }
                                            // Remaining API request and dialog code...
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0XFFAA0123),
                                      ),
                                      child: isLoading
                                          ? const SizedBox(
                                              width: 25,
                                              height: 25,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        Color(0XFFFFFFFF)),
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
                                const SizedBox(height: 20),
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
                    SizedBox(height: 3),
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
