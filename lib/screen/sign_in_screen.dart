import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telfood/helper/app_colors.dart';
import 'package:telfood/helper/navigators.dart';
import 'package:telfood/screen/menu_screen.dart';
import 'package:telfood/screen/sign_up_screen.dart';
import 'package:telfood/widgets/text_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  bool obscureText = true;
  bool rememberMe = false;

  Future<void> signIn() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: tecEmail.text,
          password: tecPassword.text,
        );

        // Get the user's display name
        String userName = userCredential.user?.displayName ?? 'User';

        // Navigate to the main menu screen if sign-in is successful
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MenuScreen(name: userName)),
        );
      } on FirebaseAuthException catch (e) {
        // Handle error
        String message;
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided.';
        } else {
          message = 'An error occurred. Please try again.';
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Sign in to Firebase with the Google [UserCredential]
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Get the user's display name
      String userName = userCredential.user?.displayName ?? 'User';

      // Navigate to the main menu screen if sign-in is successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MenuScreen(name: userName)),
      );
    } on FirebaseAuthException catch (e) {
      // Handle error
      String message = 'An error occurred. Please try again.';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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
                    text: "Masuk",
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
                        const TextSpan(text: "Masuk ke akun "),
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
                              email(),
                              const SizedBox(height: 20),
                              password(),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: rememberMe,
                                        onChanged: (value) {
                                          setState(() {
                                            rememberMe = value!;
                                          });
                                        },
                                      ),
                                      const TextSheet(
                                        text: "Ingat Saya",
                                        color: AppColors.grey,
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const TextSheet(
                                      text: "Lupa Sandi",
                                      color: AppColors.maroon,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                child: FilledButton(
                                  onPressed: signIn,
                                  style: FilledButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    backgroundColor: AppColors.maroon,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const TextSheet(
                                    text: "Masuk",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const TextSheet(
                              text: "Belum punya akun? ",
                              color: AppColors.grey,
                              size: 16,
                            ),
                            InkWell(
                              onTap: () {
                                Navigators.push(context, const SignUpScreen());
                              },
                              child: const TextSheet(
                                text: "DAFTAR SEKARANG",
                                color: AppColors.maroon,
                                size: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Center(
                          child: TextSheet(
                            text: "Atau",
                            textAlign: TextAlign.center,
                            color: AppColors.grey,
                            size: 16,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: SizedBox.square(
                                dimension: MediaQuery.of(context).size.width * 0.15,
                                child: Image.asset("assets/image/btn-facebook.png"),
                              ),
                            ),
                            SizedBox(width: (MediaQuery.of(context).size.width * 0.05) + 10),
                            InkWell(
                              onTap: () {},
                              child: SizedBox.square(
                                dimension: MediaQuery.of(context).size.width * 0.15,
                                child: Image.asset("assets/image/btn-twitter.png"),
                              ),
                            ),
                            SizedBox(width: (MediaQuery.of(context).size.width * 0.05) + 5),
                            InkWell(
                              onTap: signInWithGoogle,
                              child: SizedBox.square(
                                dimension: MediaQuery.of(context).size.width * 0.175,
                                child: Image.asset("assets/image/btn-google.png"),
                              ),
                            ),
                          ],
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
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Masukkan email yang valid';
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
          obscureText: obscureText,
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
                  obscureText = !obscureText;
                });
              },
              icon: Icon(
                obscureText ? Icons.visibility_off_outlined : Icons.visibility,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password tidak boleh kosong';
            }
            if (value.length < 6) {
              return 'Password harus terdiri dari minimal 6 karakter';
            }
            return null;
          },
        ),
      ],
    );
  }
}
