import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    //show dialog

    showDialog(
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      context: context,
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }

    Navigator.pop(context);
  }

  void wrongEmailMessage() {
    Navigator.pop(context);

    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Color.fromARGB(255, 7, 11, 129),
            title: Center(
              child: Text(
                "Email anda tidak terdaftar",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
  }

  void wrongPasswordMessage() {
    Navigator.pop(context);

    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Color.fromARGB(255, 7, 11, 129),
            title: Center(
              child: Text(
                "Password anda salah",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
  }

  bool _obscureText = true;
  late Size size;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: null,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 7, 11, 129)),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    "assets/image/kk.png",
                    width: size.width * 0.4,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: const [
                      Text(
                        "Selamat Datang!",
                        style: TextStyle(
                          color: Color.fromARGB(255, 55, 89, 240),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Silahkan masuk dengan akun Anda",
                        style: TextStyle(
                          color: Color.fromARGB(255, 55, 89, 240),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const Text(
                            "Masuk",
                            style: TextStyle(
                              color: Color.fromARGB(255, 7, 11, 129),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: _emailController,
                            maxLines: null,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: Icon(_obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              hintText: 'Kata Sandi',
                              hintStyle: const TextStyle(
                                fontSize: 14,
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: signIn,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                    left: 85,
                                    right: 85,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 55, 89, 240),
                                    borderRadius: BorderRadius.circular(4),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.6),
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: const Text(
                                    "Masuk",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Belum punya akun?",
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 55, 89, 240),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        InkWell(
                                          onTap: widget.onTap,
                                          child: const Text(
                                            "Daftar",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 55, 89, 240),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 60,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: const [
                                      Text(
                                        "Copyright 2023 - KasirKita",
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
