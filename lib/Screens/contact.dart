import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController(),
      _emailController = TextEditingController(),
      _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text('Contact Us', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'GET IN TOUCH',
              style: AppStyles.title,
              textAlign: TextAlign.center,
            ),
            Container(width: 75, height: 2, color: AppColors.yellow),
            const SizedBox(height: 3),
            Container(width: 50, height: 2, color: AppColors.yellow),
            const SizedBox(height: 50),
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContactInfo(
                      'assets/email.png',
                      'Mail Us:',
                      AppConstants.mail,
                    ),
                    const SizedBox(height: 20),
                    _buildContactInfo(
                      'assets/call.png',
                      'Call Us:',
                      AppConstants.phone,
                    ),
                    const SizedBox(height: 20),
                    _buildContactInfo(
                      'assets/pin.png',
                      'Visit Us:',
                      AppConstants.location,
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                _buildContactForm(context),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(String imagePath, String title, String content) {
    return FittedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppIcon(imagePath, color: AppColors.black.withOpacity(.7), size: 20),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                content,
                style: TextStyle(color: AppColors.black.withOpacity(.7)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Have Something To Write?',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 25),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: (text) {
                        return (text!.isValidName())
                            ? null
                            : 'Please insert valid name!';
                      },
                      decoration: InputDecoration(
                        hintText: 'Your Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: (text) {
                        return (text!.isValidEmail)
                            ? null
                            : 'Please insert valid email!';
                      },
                      decoration: const InputDecoration(
                        hintText: 'Your Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                minLines: 3,
                maxLines: 10,
                validator: (text) {
                  return (text!.isValidName(minLength: 10))
                      ? null
                      : 'Please insert valid message!, at least 10 characters';
                },
                decoration: const InputDecoration(
                  hintText: 'Your Message',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendMail,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Text('Send'),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _sendMail() async {
    bool isValidForm = _formKey.currentState!.validate();
    if (!isValidForm) return;

    final mailto = Mailto(
      to: [AppConstants.mail],
      subject: _nameController.text.trim(),
      body: _contentController.text.trim(),
    );

    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 3000);
    String renderHtml(Mailto mailto) =>
        '''<html><head><title>mailto example</title></head><body><a href="$mailto">Open mail client</a></body></html>''';
    await for (HttpRequest request in server) {
      request.response
        ..statusCode = HttpStatus.ok
        ..headers.contentType = ContentType.html
        ..write(renderHtml(mailto));
      await request.response.close();
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(
              'Your Email has been send Successfully .Our Team will Contact you soon'),
        ));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}

mixin AppStyles {
  static final TextStyle title = TextStyle(
    color: AppColors.black.withOpacity(.8),
    fontSize: 35,
    fontWeight: FontWeight.w700,
  );
}
mixin AppColors {
  static final yellow = Colors.yellow[800];

  static final black = Colors.black87;

  static final greyLight = Colors.grey[100];
}
mixin AppConstants {
  static final String mail = 'Bingo-Agency/MrWorker@gmail.com';

  static final String phone = '(+92)333-5714484 ';
  static final String location = 'Bingo Agency G-12 ,Islamabad, Pakistan';
}

class AppIcon extends StatelessWidget {
  final String path;
  final double size;
  final Color color;
  final Color? background;

  const AppIcon(this.path,
      {Key? key, this.size = 25, this.color = Colors.white, this.background})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      child: Image.asset(path, color: color, height: size, width: size),
    );
  }
}

extension StringExtensions on String {
  bool get isValidEmail => RegExp(
          "^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this.trim());

  bool isValidName({minLength = 3}) =>
      this.trim().isNotEmpty && (this.trim().length >= minLength);
}
