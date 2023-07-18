import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stunnzone/widgets/yellow_button.dart';

const textColors = [
  Colors.yellowAccent,
  Color(0xff5F2879),
  Color(0xff00418D),
  Color(0xff00C2DE),
  Color(0xff00BA71),
  Color(0xffFAD717),
  Color(0xffFA8901),
  Color(0xffF43545),
];

const textStyle =
    TextStyle(fontSize: 45, fontWeight: FontWeight.bold, fontFamily: "Acme");

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  bool processing = false;
  CollectionReference customer =
      FirebaseFirestore.instance.collection('customers');
  late String _uid;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.repeat();
    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/inapp/bgimage.jpg'),
                fit: BoxFit.cover)),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText('WELCOME',
                      textStyle: textStyle, colors: textColors),
                  ColorizeAnimatedText('STUNNZONE',
                      textStyle: textStyle, colors: textColors)
                ],
                repeatForever: true,
                isRepeatingAnimation: true,
              ),
              const SizedBox(
                height: 120,
                width: 200,
                child: Image(
                  image: AssetImage('images/inapp/logo.jpg'),
                ),
              ),
              SizedBox(
                height: 80,
                child: DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 45,
                      fontFamily: 'Acme',
                      color: Colors.lightBlueAccent),
                  child: AnimatedTextKit(animatedTexts: [
                    RotateAnimatedText('Awesome'),
                    RotateAnimatedText('STUNNZONE'),
                    RotateAnimatedText('SHOP'),
                  ]),
                ),
              ),
              /*const Text(
                'SHOP',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Supplier Only',
                            style: TextStyle(
                              fontSize: 26,
                              color: Colors.yellowAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: const BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AnimatedLogo(controller: _controller),
                            YellowButton(
                              width: 0.25,
                              label: 'Lon in',
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/supplier_login');
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: YellowButton(
                                width: 0.25,
                                label: 'Sign Up',
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/supplier_signup');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: const BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: YellowButton(
                            width: 0.25,
                            label: 'Sign Up',
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/customer_signup');
                            },
                          ),
                        ),
                        YellowButton(
                          width: 0.25,
                          label: 'Lon in',
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/customer_login');
                          },
                        ),
                        AnimatedLogo(controller: _controller),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white38,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GoogleFacebookLogin(
                        label: 'Google',
                        onPressed: () {},
                        child: const Image(
                            image: AssetImage('images/inapp/google.jpg')),
                      ),
                      GoogleFacebookLogin(
                        label: 'Facebook',
                        onPressed: () {},
                        child: const Image(
                          image: AssetImage('images/inapp/facebook.jpg'),
                        ),
                      ),
                      processing == true
                          ? CircularProgressIndicator()
                          : GoogleFacebookLogin(
                              label: 'Guest',
                              onPressed: () async {
                                setState(() {
                                  processing = true;
                                });
                                await FirebaseAuth.instance
                                    .signInAnonymously()
                                    .whenComplete(() async {
                                      _uid  = FirebaseAuth.instance.currentUser!.uid;
                                  await customer.doc(_uid).set({
                                    'name': '',
                                    'email': '',
                                    'profileImage': '',
                                    'phone': '',
                                    'address': '',
                                    'cid': _uid,
                                  });
                                });

                                Navigator.pushReplacementNamed(
                                    context, '/customer_home');
                              },
                              child: const Icon(
                                Icons.person,
                                size: 55,
                                color: Colors.lightBlueAccent,
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
    );
  }
}

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({
    super.key,
    required AnimationController controller,
  }) : _controller = controller;

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: child,
        );
      },
      animation: _controller.view,
      child: const Image(
        image: AssetImage('images/inapp/logo.jpg'),
      ),
    );
  }
}

class GoogleFacebookLogin extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Widget child;

  const GoogleFacebookLogin({
    required this.label,
    required this.onPressed,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: child,
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
