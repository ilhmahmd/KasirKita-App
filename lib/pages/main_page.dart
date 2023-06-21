// ignore_for_file: avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kasir_kita/pages/auth_page/auth_page.dart';
import 'package:kasir_kita/pages/auth_page/register_page.dart';
import 'homepage/home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return AuthPage();
          }
        },
        // child: Align(
        //   alignment: Alignment.center,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Image.asset(
        //         'assets/image/kk.png',
        //         width: size.width * 0.4,
        //       ),
        //       const SizedBox(
        //         height: 20,
        //       ),
        //       InkWell(
        //         onTap: () {},
        //         child: Column(
        //           children: [
        //             Container(
        //               padding: const EdgeInsets.only(
        //                 top: 10,
        //                 bottom: 10,
        //                 left: 85,
        //                 right: 85,
        //               ),
        //               decoration: BoxDecoration(
        //                 color: const Color.fromARGB(255, 55, 89, 240),
        //                 borderRadius: BorderRadius.circular(4),
        //                 boxShadow: [
        //                   BoxShadow(
        //                     color: Colors.grey.withOpacity(0.6),
        //                     offset: const Offset(0, 3),
        //                   ),
        //                 ],
        //               ),
        //               child: const Text(
        //                 "Daftar",
        //                 style: TextStyle(
        //                   color: Colors.white,
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 20,
        //       ),
        //       Column(
        //         children: [
        //           Container(
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 const Text(
        //                   "Sudah punya akun?",
        //                   style: TextStyle(
        //                     color: Color.fromARGB(255, 55, 89, 240),
        //                   ),
        //                 ),
        //                 const SizedBox(
        //                   width: 6,
        //                 ),
        //                 InkWell(
        //                   onTap: () {},
        //                   child: const Text(
        //                     "Masuk",
        //                     style: TextStyle(
        //                       color: Color.fromARGB(255, 55, 89, 240),
        //                       fontWeight: FontWeight.bold,
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
