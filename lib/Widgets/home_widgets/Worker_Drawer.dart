import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mrworker/AppState/database.dart';
import 'package:mrworker/Screens/AboutPage.dart';
import 'package:mrworker/Screens/authScreen.dart';
import 'package:mrworker/Screens/contact.dart';
import 'package:mrworker/Screens/emergencyScreen.dart';
import 'package:mrworker/Widgets/home_widgets/categoryPage.dart';
import 'package:provider/provider.dart';

class Worker_Drawer extends StatelessWidget {
  const Worker_Drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dbclass = context.read<DataBase>();
    dbclass.checkAuth();
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/logo.png'),
              ),
            ),
            child: Text(''),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const categoryPage(),
                ),
              );
            },
            title: const Text(
              'Listing',
              style: TextStyle(color: Colors.black),
            ),
            leading: const FaIcon(FontAwesomeIcons.servicestack),
            iconColor: Colors.black,
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EmergencyScreen(),
                ),
              );
            },
            title: const Text(
              'Emergency Services',
              style: TextStyle(color: Colors.black),
            ),
            leading: const Icon(Icons.lightbulb_circle_rounded),
            iconColor: Colors.black,
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutPage(),
                ),
              );
            },
            title: const Text(
              'About Us',
              style: TextStyle(color: Colors.black),
            ),
            leading: const FaIcon(FontAwesomeIcons.addressCard),
            iconColor: Colors.black,
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactUs(),
                ),
              );
            },
            title: const Text(
              'Contact us',
              style: TextStyle(color: Colors.black),
            ),
            leading: const FaIcon(FontAwesomeIcons.phone),
            iconColor: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Divider(
              color: Theme.of(context).primaryColor,
              thickness: 1.0,
            ),
          ),
          Consumer<DataBase>(builder: (context, val, child) {
            return (val.isLoggedIn == false)
                ? ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AuthScreen(),
                        ),
                      );
                    },
                    title: const Text(
                      "Login",
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: const FaIcon(FontAwesomeIcons.unlock),
                    iconColor: Colors.black,
                  )
                : ListTile(
                    onTap: () async {
                      await dbclass.logOut();
                      (dbclass.isLoggedIn == false)
                          ? Navigator.pop(context)
                          : Navigator.pop(context);
                    },
                    title: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: const FaIcon(FontAwesomeIcons.lock),
                    iconColor: Colors.black,
                  );
          }),
          const Divider(),
        ],
      ),
    );
  }
}
