import 'package:dynamic_fa_icons/dynamic_fa_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mrworker/AppState/database.dart';
import 'package:provider/provider.dart';
import '../Details/DetailPage3.dart';

class Home_Categories extends StatelessWidget {
  const Home_Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Consumer<DataBase>(
        builder: (context, value, child) {
          return value.mapCategory.isEmpty && !value.errorCategory
              ? const Center(child: CircularProgressIndicator())
              : value.errorCategory
                  ? Text(
                      'Oops, something went wrong .${value.errorMessageCategory}',
                      textAlign: TextAlign.center,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: value.mapCategory['categories'].length,
                      itemBuilder: (context, index) {
                        Map map = value.mapCategory['categories'][index];
                        return GestureDetector(
                          onTap: () {
                            print(map['name'].toString());
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    detailpage3(curl: map['name'].toString()),
                              ),
                            );
                          },
                          child: Container(
                            width: 150,
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // FaIcon(FontAwesomeIcons.computer,size: 40.0,color: Colors.black),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: FaIcon(
                                      DynamicFaIcons.getIconFromName(
                                          map['icon']),
                                      size: 40.0,
                                      color: Color(
                                        int.parse(map['color']),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        map['title'],
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
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
    );
  }
}
