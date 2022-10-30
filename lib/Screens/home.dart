import 'package:flutter/material.dart';
import 'package:mrworker/AppState/database.dart';
import 'package:mrworker/Widgets/home_widgets/Worker_Drawer.dart';
import 'package:mrworker/Widgets/home_widgets/bottomNav.dart';
import 'package:mrworker/Widgets/home_widgets/emergencyServices.dart';
import 'package:mrworker/Widgets/home_widgets/getHired.dart';
import 'package:mrworker/Widgets/home_widgets/home_popular.dart';
import 'package:mrworker/Widgets/home_widgets/recommended.dart';
import 'package:mrworker/Widgets/home_widgets/rightProfileIcon.dart';
import 'package:mrworker/Widgets/home_widgets/searchCityBar.dart';
import 'package:mrworker/Widgets/home_widgets/topBanner.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<DataBase>().fetchPopular;
    context.read<DataBase>().fetchCategory;
    context.read<DataBase>().fetchRecommendation;
    context.read<DataBase>().getCity();
    context.read<DataBase>().checkAuth();

    var dbclass = context.read<DataBase>();

    return Scaffold(
      drawer: const Worker_Drawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xffEBECED),
        title: const Padding(
          padding: EdgeInsets.only(left: 60),
          child: Text(
            'Mr.Worker',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: const [
          RightProfileIcon(),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            TopBanner(),
            SearchCityBar(),
            SizedBox(
              height: 10,
            ),
            Home_Popular(),
            SizedBox(
              height: 10,
            ),
            Recommended(),
            SizedBox(
              height: 10,
            ),
            GetHired(),
            SizedBox(
              height: 10,
            ),
            EmergencyServices(),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
