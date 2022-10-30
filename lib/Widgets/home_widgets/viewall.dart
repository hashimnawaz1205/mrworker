import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrworker/AppState/database.dart';
import 'package:provider/provider.dart';

import '../Details/DetailPage3.dart';

class viewall extends StatelessWidget {
  const viewall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<DataBase>().fetchCategory;
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
          title: const Text('All Categories'),
          backgroundColor: const Color(0xFFEBECED),
          foregroundColor: Colors.black),
      body: Consumer<DataBase>(
        builder: (context, value, child) {
          return value.mapCategory.isEmpty && !value.errorCategory
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black12,
                    backgroundColor: Colors.black12,
                  ),
                )
              : value.errorCategory
                  ? Text(
                      'Oops, something went wrong .${value.errorMessageCategory}',
                      textAlign: TextAlign.center,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.mapCategory['categories'].length,
                      itemBuilder: (context, index) {
                        var map = value.mapCategory['categories'][index];
                        String name = map['name'];

                        var finalName = name[0].toUpperCase() +
                            name.substring(1).toLowerCase();
                        return Card(
                          child: ListTile(
                            onTap: () {
                              print(map['name'].toString());
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      detailpage3(curl: map['name'].toString()),
                                ),
                              );
                            },
                            title: Text(
                              finalName.toString(),
                            ),
                            trailing: const Icon(FontAwesomeIcons.chevronRight),
                          ),
                        );
                      });

          // GridView.builder(
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: (orientation == Orientation.portrait) ? 4 : 4),
          //   itemCount: value.mapCategory['categories'].length,
          //   itemBuilder:
          //       // shrinkWrap: true,
          //       // scrollDirection: Axis.horizontal,
          //       // itemCount: value.mapCategory['categories'].length,
          //       (context, index) {
          //     var map = value.mapCategory['categories'][index];
          //     String name = map['name'];
          //
          //     var finalName =
          //         name[0].toUpperCase() + name.substring(1).toLowerCase();
          //     return InkWell(
          //       onTap: () {
          //         print(map['name'].toString());
          //         Navigator.of(context).push(
          //           MaterialPageRoute(
          //             builder: (BuildContext context) =>
          //                 detailpage3(curl: map['name'].toString()),
          //           ),
          //         );
          //       },
          //       child: Container(
          //         // width: 150,
          //         // margin: const EdgeInsets.all(4),
          //         margin: const EdgeInsets.only(right: 6.0, left: 4.0),
          //         // padding: const EdgeInsets.all(4),
          //         decoration: BoxDecoration(
          //             borderRadius: const BorderRadius.only(
          //               topRight: Radius.circular(8.0),
          //               bottomRight: Radius.circular(8.0),
          //             ),
          //             color: Colors.white,
          //             boxShadow: const [
          //               BoxShadow(
          //                   color: Color(0xffd4d4d9),
          //                   spreadRadius: 0.5,
          //                   blurRadius: 2.0),
          //             ],
          //             border: Border.all(color: Colors.black12)),
          //         child: Center(
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Text(
          //               finalName,
          //               style: GoogleFonts.montserrat(
          //                 textStyle: const TextStyle(
          //                     color: Colors.black,
          //                     fontSize: 10.0,
          //                     fontWeight: FontWeight.bold),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // );
        },
      ),
    );
  }
}
