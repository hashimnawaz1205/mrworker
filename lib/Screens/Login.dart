import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrworker/AppState/database.dart';
import 'package:mrworker/Screens/NewRegister.dart';
import 'package:mrworker/Screens/forgetPassword.dart';
import 'package:mrworker/Screens/home.dart';
import 'package:provider/provider.dart';

class Mylogin extends StatelessWidget {
  const Mylogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map;
    String message;
    var dbclass = context.read<DataBase>();

    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
          title: const Text('Login'),
          backgroundColor: const Color(0xFFEBECED),
          foregroundColor: Colors.black),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                height: 320,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Login & Find over 54,000 Workers",
                          style: GoogleFonts.montserrat(
                              fontSize: 26.0,
                              color: Theme.of(context).primaryColor),
                        ), //BoxDecoration
                      ), //Container
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    // Text(
                    //     'Register and get access to 54,000 database records'),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Image(
                            fit: BoxFit.contain,
                            image: AssetImage('assets/logo.png'),
                          ) //BoxDecoration
                          ), //Container
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Login',
                  style: GoogleFonts.montserrat(
                      fontSize: 18, color: Theme.of(context).primaryColor),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      labelText: 'Phone',
                      labelStyle: GoogleFonts.ubuntu(
                          color: Theme.of(context).primaryColor)),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      labelText: 'Password',
                      labelStyle: GoogleFonts.ubuntu(
                          color: Theme.of(context).primaryColor)),
                ),
              ),
              TextButton(
                onPressed: () {
                  //forgot password screen
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const ForgetPassword(),
                    ),
                  );
                },
                child: Text(
                  'Forgot Password',
                  style: GoogleFonts.montserrat(
                      color: Theme.of(context).primaryColor),
                ),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                color: Colors.grey,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  child: const Text('Login'),
                  onPressed: () async {
                    // print(loginMap['message']);
                    var email = phoneController.text.toString();
                    var password = passwordController.text.toString();
                    //print
                    var userclass = await dbclass.userLogin(email, password);
                    map = await dbclass.mapLogin;
                    message = await dbclass.mapLogin['message'].toString();
                    //checking map if its empty or shit
                    if (map.isEmpty) {
                      print('map is empty');
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title:
                              Text('Warning', style: GoogleFonts.montserrat()),
                          content: FutureBuilder(
                            future: dbclass.userLogin(email, password),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data.toString(),
                                  softWrap: true,
                                  style: GoogleFonts.montserrat(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                );
                              } else {
                                return const SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop(); // dismisses only the dialog and returns nothing
                              },
                              child: Text(
                                'Try again',
                                style: GoogleFonts.montserrat(),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      if (message.isNotEmpty && message == 'True') {
                        //shared prefs !!!

                        print('True');
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) => const Home(),
                          ),
                        );
                      } else if (message.isNotEmpty && message == 'False') {
                        print('False');
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'Warning',
                              style: GoogleFonts.montserrat(),
                            ),
                            content: Text(
                              'Invalid Credentials,Login Failed',
                              style: GoogleFonts.montserrat(),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(); // dismisses only the dialog and returns nothing
                                },
                                child: Text(
                                  'Try again',
                                  style: GoogleFonts.montserrat(),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                    print(phoneController.text);
                    print(passwordController.text);
                  },
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Does not have account?',
                    style: GoogleFonts.montserrat(),
                  ),
                  TextButton(
                    child: Text(
                      'Register',
                      style: GoogleFonts.montserrat(
                          fontSize: 18, color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      //signup screen
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => RegisterNew(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          )),
    );
  }
}
