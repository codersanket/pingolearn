import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pingolearn/app/app_bootstratper.dart';
import 'package:pingolearn/screens/authentication/auth_provider.dart';
import 'package:pingolearn/screens/home/home.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (BuildContext context) => locator(),
      child: Consumer<AuthProvider>(
        builder: (context, value, child) {
          if (value.userStatus == UserStatus.loggedOut) {
            return const LogIn();
          }
          if (value.userStatus == UserStatus.loggedIn) return Home();

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, snapshot, child) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Text(
                  "e-Shop",
                  style: GoogleFonts.poppins(
                      color: Color(0xff0C54BE),
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
              Form(
                key: snapshot.key,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Enter valid email";
                          }
                          const regex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

                          if (RegExp(regex).hasMatch(value!)) return null;

                          return "Enter valid email";
                        },
                        onChanged: (value) => snapshot.email = value,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          hintText: "Email",
                          filled: true,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Enter valid Password";
                          }
                          const regex =
                              r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$';

                          if (RegExp(regex).hasMatch(value!)) return null;

                          return "Enter valid Password";
                        },
                        onChanged: (value) => snapshot.password = value,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            hintText: "Password",
                            filled: true),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      if (snapshot.isRegistering)
                        TextFormField(
                          onChanged: (value) => snapshot.name = value,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Enter valid Name";
                            }
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              hintText: "Name",
                              filled: true),
                        ),
                    ],
                  ),
                ),
              ),
              Center(
                child: snapshot.isLoading
                    ? Center(
                        child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 28,
                          ),
                        ],
                      ))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: MaterialButton(
                              color: Color(0xff0C54BE),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              onPressed: snapshot.onClick,
                              child: Text(
                                !snapshot.isRegistering ? "Login" : "SignUp",
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          RichText(
                            text: TextSpan(
                              text: !snapshot.isRegistering
                                  ? "Already have an account? "
                                  : "New here? ",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                  text: !snapshot.isRegistering
                                      ? "Sign UP"
                                      : "Login",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = snapshot.onRichTextClick,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff0C54BE),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 62,
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
