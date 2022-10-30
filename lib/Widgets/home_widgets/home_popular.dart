import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrworker/AppState/database.dart';
import 'package:mrworker/Widgets/home_widgets/viewall.dart';
import 'package:provider/provider.dart';

import '../Details/DetailPage3.dart';

class Home_Popular extends StatelessWidget {
  const Home_Popular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Categories',
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const viewall(),
                    ),
                  );
                },
                child: Text(
                  'View All',
                  style: GoogleFonts.montserrat(
                      color: const Color(0xFFa51b1f),
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Consumer<DataBase>(
              builder: (context, value, child) {
                return value.mapPopular.isEmpty && !value.errorPopular
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black12,
                          backgroundColor: Colors.black12,
                        ),
                      )
                    : value.errorPopular
                        ? Text(
                            'Oops, something went wrong .${value.errorMessagePopular}',
                            textAlign: TextAlign.center,
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: value.mapPopular['popular'].length,
                            itemBuilder: (context, index) {
                              var map = value.mapPopular['popular'][index];
                              String name = map['name'];

                              var finalName = name[0].toUpperCase() +
                                  name.substring(1).toLowerCase();
                              return InkWell(
                                onTap: () {
                                  print(map['name'].toString());
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          detailpage3(
                                              curl: map['name'].toString()),
                                    ),
                                  );
                                },
                                child: Container(
                                  // width: 150,
                                  // margin: const EdgeInsets.all(4),
                                  margin: const EdgeInsets.only(
                                      right: 6.0, left: 4.0),
                                  // padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(8.0),
                                        bottomRight: Radius.circular(8.0),
                                      ),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color(0xffd4d4d9),
                                            spreadRadius: 0.5,
                                            blurRadius: 2.0),
                                      ],
                                      border:
                                          Border.all(color: Colors.black12)),
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0,
                                              bottom: 8.0,
                                              left: 18.0,
                                              right: 18.0),
                                          child: Text(finalName,
                                              style: GoogleFonts.montserrat(
                                                textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              softWrap: true),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
              },
            ),
          ),
        ),
      ],
    );
  }
}
