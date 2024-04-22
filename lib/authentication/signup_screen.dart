// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vapusuario/authentication/login_screen.dart';

import '../methods/common_methods.dart';
import '../pages/home_page.dart';
import '../widgets/loading_dialog.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController userPhoneTextEditingController =
      TextEditingController();
  TextEditingController cpfTextEditingController = TextEditingController();
  TextEditingController genderTextEditingController = TextEditingController();
  TextEditingController birthdayTextEditingController = TextEditingController();
  CommonMethods cMethods = CommonMethods();

  checkIfNetworkIsAvailable() {
    cMethods.checkConnectivity(context);

    signUpFormValidation();
  }

  signUpFormValidation() {
    if (userNameTextEditingController.text.trim().length < 3) {
      cMethods.displaySnackBar(
          "your name must be atleast 4 or more characters.", context);
    } else if (userPhoneTextEditingController.text.trim().length < 7) {
      cMethods.displaySnackBar(
          "your phone number must be atleast 8 or more characters.", context);
    } else if (!emailTextEditingController.text.contains("@")) {
      cMethods.displaySnackBar("please write valid email.", context);
    } else if (passwordTextEditingController.text.trim().length < 5) {
      cMethods.displaySnackBar(
          "your password must be atleast 6 or more characters.", context);
    } else {
      registerNewUser();
    }
  }

  registerNewUser() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          LoadingDialog(messageText: "Registering your account..."),
    );

    final User? userFirebase = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    )
            .catchError((errorMsg) {
      Navigator.pop(context);
      cMethods.displaySnackBar(errorMsg.toString(), context);
    }))
        .user;

    if (!context.mounted) return;
    Navigator.pop(context);

    DatabaseReference usersRef =
        FirebaseDatabase.instance.ref().child("users").child(userFirebase!.uid);
    Map userDataMap = {
      "id": userFirebase.uid,
      "name": userNameTextEditingController.text.trim(),
      "email": emailTextEditingController.text.trim(),
      "phone": userPhoneTextEditingController.text.trim(),
      "CPF": cpfTextEditingController.text.trim(),
      "gender": genderTextEditingController.text.trim(),
      "birthday": birthdayTextEditingController.text.trim(),
      "blockStatus": "no",
    };
    usersRef.set(userDataMap);

    Navigator.push(context, MaterialPageRoute(builder: (c) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SafeArea(
                child: Center(
                  child: Image.asset(
                    'assets/Vaplogo.png',
                    width: 200,
                    height: 220,
                  ),
                ),
              ),
              Text(
                'Criar conta',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),

              //TextField
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    //Name
                    TextField(
                      controller: userNameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    //email
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    //password
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Passoword',
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    //phone
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: userPhoneTextEditingController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    //cpf
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: cpfTextEditingController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'CPF',
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    //gender
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: genderTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'gender',
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    //birthday
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: birthdayTextEditingController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Birthday',
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        checkIfNetworkIsAvailable();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 10,
                        ),
                      ),
                      child: Text('Sign Up'),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 0,
              ),

              //Textbutton
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => LoginScreen()));
                },
                child: Text(
                  'Já tem uma conta? Login aqui!',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
