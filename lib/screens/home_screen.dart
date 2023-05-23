import 'dart:async';
import 'package:born_to_prophecy/screens/registrations/already_registered_screen.dart';
import 'package:born_to_prophecy/screens/registrations/new_registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:born_to_prophecy/function/wave_pop.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();
  String? _gender;
  String? _soi;


  void clearForm1() {
    setState(() {
      _formKey.currentState?.reset();
      _nameController.clear();
      _phoneNumberController.clear();
      _addressController.clear();
      _nationalityController.clear();
      _occupationController.clear();
      _gender = null; // Clear the selected gender
      _soi = null;


      submittedRegistration = false;
    });
  }
  void clearForm2() {
    setState(() {
      _phoneNumberController.clear();
      submitted = false;
    });
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
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), setSystemUIModeNormal);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background/1.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.4), BlendMode.dstATop),
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Positioned(
            top: 15,
            child: Center(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/images/background/2.png',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 180,
            child: Image.asset(
              'assets/images/welcome.png',
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 2, // Set a higher flex value for the left container
                child: Container(
                  // null
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3.35,
                            margin: const EdgeInsets.all(6),
                            height: 180,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(
                                  0XFFA50021), // Replace with your desired color
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const NewRegistration()),
                              );
                              clearForm1();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3.35,
                              height: 180,
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(
                                    0XFFA50021), // Replace with your desired color
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.only(left: 8),
                                      // Adjust the padding value as needed
                                      child: const Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "New\nRegistration",
                                            style: TextStyle(
                                                fontSize: 27,
                                                color: Colors.white,
                                                fontFamily: 'Raleway'),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "You would be required to enter some details.",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontFamily: 'Raleway'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            "assets/images/saly.png",
                                            alignment: Alignment.centerRight,
                                            height: 200,
                                            width: 200,
                                            fit: BoxFit.contain,
                                          ),
                                          const Align(
                                            alignment: Alignment.bottomRight,
                                            child: AnimatedCircleContainer(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3.35,
                            margin: const EdgeInsets.all(6),
                            height: 185,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(
                                  0XFF330034), // Replace with your desired color
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AlreadyRegistered()),
                              );
                              clearForm2();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3.35,
                              height: 185,
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(
                                    0XFF330034), // Replace with your desired color
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.only(left: 8),
                                      // Adjust the padding value as needed
                                      child: const Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Already\nRegistered",
                                            style: TextStyle(
                                                fontSize: 27,
                                                color: Colors.white,
                                                fontFamily: 'Raleway'),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "Tap here to confirm your previous registration",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontFamily: 'Raleway'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            "assets/images/saly.png",
                                            alignment: Alignment.centerRight,
                                            height: 200,
                                            width: 200,
                                            fit: BoxFit.contain,
                                          ),
                                          const Align(
                                            alignment: Alignment.bottomRight,
                                            child: AnimatedCircleContainer(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
