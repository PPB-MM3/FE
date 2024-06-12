import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:telfood/helper/app_colors.dart';
import 'package:telfood/helper/navigators.dart';
import 'package:telfood/widgets/text_sheet.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController tecName = TextEditingController();
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecPassword = TextEditingController();
  TextEditingController tecPasswordConfirmation = TextEditingController();

  bool obscureTextP = true;
  bool obscureTextPC = true;

  Future<void> register() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: tecEmail.text,
          password: tecPassword.text,
        );
        // You can also set the display name for the user
        await userCredential.user?.updateDisplayName(tecName.text);
        // Navigate to another screen or show success message
        print("User registered: ${userCredential.user?.email}");
      } on FirebaseAuthException catch (e) {
        // Handle error
        print("Error: ${e.message}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellow,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.225,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
              ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  const TextSheet(
                    text: "Daftar",
                    fontWeight: FontWeight.w800,
                    size: 30,
                    color: AppColors.maroon,
                  ),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.sen(
                        fontWeight: FontWeight.w400,
                        color: AppColors.maroon,
                        fontSize: 14,
                      ),
                      children: [
                        const TextSpan(text: "Daftarkan akun "),
                        TextSpan(
                          text: "Telfood",
                          style: GoogleFonts.sen(
                            fontWeight: FontWeight.w700,
                            color: AppColors.maroon,
                            fontSize: 14,
                          ),
                        ),
                        const TextSpan(text: " kamu sekarang"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Card(
                margin: EdgeInsets.zero,
                color: Colors.white,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 40,
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              name(),
                              const SizedBox(height: 20),
                              email(),
                              const SizedBox(height: 20),
                              password(),
                              const SizedBox(height: 20),
                              passwordConfirmation(),
                              const SizedBox(height: 40),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                child: FilledButton(
                                  onPressed: register,
                                  style: FilledButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    backgroundColor: AppColors.maroon,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const TextSheet(
                                    text: "Daftar",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
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
      floatingActionButton: SizedBox.square(
        dimension: 45,
        child: FloatingActionButton(
          onPressed: () {
            Navigators.pop(context);
          },
          elevation: 0,
          backgroundColor: AppColors.maroon,
          foregroundColor: Colors.white,
          shape: CircleBorder(),
          child: const Icon(Icons.navigate_before),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  Widget name() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextSheet(text: "NAMA"),
        const SizedBox(height: 10),
        TextFormField(
          controller: tecName,
          keyboardType: TextInputType.name,
          style: GoogleFonts.sen(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.bgTextField,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: "Masukkan Nama Anda",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Nama tidak boleh kosong';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget email() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextSheet(text: "EMAIL"),
        const SizedBox(height: 10),
        TextFormField(
          controller: tecEmail,
          keyboardType: TextInputType.emailAddress,
          style: GoogleFonts.sen(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.bgTextField,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: "Masukkan Email Anda",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email tidak boleh kosong';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget password() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextSheet(text: "PASSWORD"),
        const SizedBox(height: 10),
        TextFormField(
          controller: tecPassword,
          obscureText: obscureTextP,
          keyboardType: TextInputType.visiblePassword,
          style: GoogleFonts.sen(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.bgTextField,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: "Masukkan Password Anda",
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureTextP = !obscureTextP;
                });
              },
              icon: Icon(obscureTextP
                  ? Icons.visibility_off_outlined
                  : Icons.visibility),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password tidak boleh kosong';
            }
            if (value.length < 6) {
              return 'Password minimal 6 karakter';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget passwordConfirmation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextSheet(text: "ULANG PASSWORD"),
        const SizedBox(height: 10),
        TextFormField(
          controller: tecPasswordConfirmation,
          obscureText: obscureTextPC,
          keyboardType: TextInputType.visiblePassword,
          style: GoogleFonts.sen(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.bgTextField,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: "Ulangi Password Anda",
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureTextPC = !obscureTextPC;
                });
              },
              icon: Icon(obscureTextPC
                  ? Icons.visibility_off_outlined
                  : Icons.visibility),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Konfirmasi password tidak boleh kosong';
            }
            if (value != tecPassword.text) {
              return 'Password tidak sama';
            }
            return null;
          },
        ),
      ],
    );
  }
}
