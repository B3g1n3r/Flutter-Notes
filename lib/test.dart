import 'package:flutter/material.dart';

class TestApp extends StatelessWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontFamily: 'Mplus 1p bold',
                fontSize: 30,
                fontWeight: FontWeight.w700,
                height: 1.2575,
                color: Color(0xff702edb),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(40, 0, 0, 32),
            child: Text(
              'Please login or sign up to continue using\nour app',
              style: TextStyle(
                fontFamily: 'Mplus 1p Bold',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                height: 1.2575,
                color: Color(0xff000000),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Enter via Social Networks',
              style: TextStyle(
                fontFamily: 'Mplus 1p Bold',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xff702edb),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              const SizedBox(width: 16),
              FloatingActionButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ],
          ),
          const Text(
            'or login with\nemail',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Mplus 1p Bold',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xff2b1e60),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(42, 0, 43, 25),
            padding: const EdgeInsets.fromLTRB(23, 20, 23, 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xffd7d7d7),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3f000000),
                  offset: Offset(0, 4),
                  blurRadius: 2,
                ),
              ],
            ),
            child: TextFormField(
              initialValue: 'Email',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Mplus 1p Bold',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xff000000),
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(42, 0, 43, 25),
            padding: const EdgeInsets.fromLTRB(23, 20, 23, 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xffd7d7d7),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3f000000),
                  offset: Offset(0, 4),
                  blurRadius: 2,
                ),
              ],
            ),
            child: TextFormField(
              initialValue: 'Password',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Mplus 1p Bold',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xff000000),
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Text(
            'Forgot Password?',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontFamily: 'YourCustomFontFamily',
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xff000000),
              height: 1.2575,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Add your button click logic here
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff930efc),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(308, 59),
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  fontFamily: 'YourCustomFontFamily',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xffffffff),
                  height: 1.2575,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
