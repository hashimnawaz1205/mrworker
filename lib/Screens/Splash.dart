import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mrworker/Screens/home.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const Home(),
        ),
      ),
    );
    return Scaffold(
      body: Container(
        color: Colors.white10,
        child: Center(
          child: CachedNetworkImage(
            imageUrl: 'https://bingo-agency.com/mrworker/img/slider%20copy.png',
          ),
        ),
      ),
    );
  }
}
