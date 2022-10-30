import 'package:flutter/material.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset('assets/update.png',
                width: MediaQuery.of(context).size.width, fit: BoxFit.contain),
          ],
        ),
      ],
    );
  }
}
