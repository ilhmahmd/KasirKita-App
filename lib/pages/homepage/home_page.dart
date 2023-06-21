import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kasir_kita/pages/profile_page/profile_page.dart';
import 'package:line_icons/line_icons.dart';

import '../../read_data/get_products.dart';
import '../product_page.dart/product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final User user = FirebaseAuth.instance.currentUser!;

  tapBottomItem(int index) {
    if (index != 4) {
      setState(() {
        _currentIndex = index;
      });
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  //document IDs
  List<String> docIDs = [];

  // get docIDs
  Future getDocID() async {
    await FirebaseFirestore.instance.collection('products').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  @override
  void initState() {
    _pageController.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: PageView(
        controller: _pageController,
        children: [
          SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  //app bar
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 24),
                    child: Image.asset(
                      'assets/image/kk.png',
                      width: size.width * 0.25,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Selamat Datang, " + user.email!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 7, 11, 129),
                    ),
                    maxLines: null,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: Color.fromARGB(255, 7, 11, 129),
                              ),
                              border: InputBorder.none,
                              hintText: 'Cari Produk?',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return const ProfilePage();
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.person_rounded,
                            color: Color.fromARGB(255, 7, 11, 129),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Produk Terbaru',
                        style: TextStyle(
                          color: Color.fromARGB(255, 7, 11, 129),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const ProductPage();
                          }));
                        },
                        child: const Text(
                          'Kelola Produk',
                          style: TextStyle(
                            color: Color.fromARGB(255, 7, 11, 129),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: SafeArea(
                        child: FutureBuilder(
                          future: getDocID(),
                          builder: (context, snapshot) {
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    textColor:
                                        const Color.fromARGB(255, 55, 89, 240),
                                    title:
                                        GetProduct(documentID: docIDs[index]),
                                  ),
                                );
                              },
                              itemCount: docIDs.length,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const ProductPage(),
        ],
      ),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          showUnselectedLabels: false,
          selectedItemColor: const Color.fromARGB(255, 7, 11, 129),
          unselectedItemColor: Colors.grey,
          onTap: tapBottomItem,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                LineIcons.home,
              ),
              label: "Beranda",
            ),
            BottomNavigationBarItem(
              icon: Icon(LineIcons.box),
              label: "Produk",
            ),
            BottomNavigationBarItem(
              icon: Icon(LineIcons.shoppingBag),
              label: "Keranjang",
            ),
            BottomNavigationBarItem(
              icon: Icon(LineIcons.history),
              label: "Riwayat",
            ),
          ],
        ),
      ),
    );
  }
}
