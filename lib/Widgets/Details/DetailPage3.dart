import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrworker/AppState/database.dart';
import 'package:mrworker/Widgets/Details/DetailPage2.dart';
import 'package:provider/provider.dart';

class detailpage3 extends StatelessWidget {
  final String curl;

  const detailpage3({Key? key, required this.curl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var db = context.read<DataBase>();
    final String city;
    city = db.initial_city.toString();
    context.read<DataBase>().Search1(curl, city);
    print(curl.toString() + city.toString());

    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFFEBECED),
          foregroundColor: Colors.black),
      body: FutureBuilder(
        future: db.Search(curl, city),
        builder: (context, snapshot) {
          print(db.mapSearch.toString());

          // if (snapshot.hasData) {
          //   print('yes it has data');
          // } else {
          //   print('not shit !');
          //   print(curl);
          //   print(city);
          // }

          if (db.mapSearch['service_search'] == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black12,
                backgroundColor: Colors.black12,
              ),
            );
          }

          if (db.mapSearch['service_search'][0]['msg'] == null) {
            print('its null');
            return ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: db.mapSearch['service_search'].length,
                itemBuilder: (BuildContext context, index) {
                  return SearchCard1(
                      map: db.mapSearch['service_search'][index]);
                });
          } else {
            return Center(
                child: Text('Sorry there is no data in This Category'));
          }

          // List myList = db.mapSearch['service_search'];
          // return ListView.builder(
          //   itemCount: myList.length,
          //     itemBuilder: (BuildContext context, index){
          //     return ListTile(
          //       leading: CachedNetworkImage(
          //         imageUrl: db.mapSearch['service_search'][index]['image'],
          //         width: 50,
          //         fit: BoxFit.cover,
          //       ),
          //       title: Text(db.mapSearch['service_search'][index]['name']),
          //     );
          //   // return Container();
          // });

          // Text(db.mapSearch['service_search'].toString());

          //
          //   ListView.builder(
          //   physics: const ClampingScrollPhysics(),
          //
          //   shrinkWrap: true,
          //   itemCount: db.mapSearch['service_search'].length,
          //   itemBuilder: (BuildContext context, index) {
          //     if(db.mapSearch['service_search'][index]
          //     ['msg'] !=
          //         'True') {
          //       return Center(
          //         child: Container(
          //           width: double.infinity,
          //           height: 500,
          //           alignment: Alignment.center,
          //           padding:
          //           const EdgeInsets.only(top: 200),
          //           child: Text(db.mapSearch['service_search'][index]
          //           ['msg']
          //               .toString()),
          //         ),
          //       );
          //     }else{
          //       print('else Working');
          //
          //       return SearchCard(
          //           map: db.mapSearch['service_search']
          //           [index]);
          //     }
          //   },
          // );
          //

          //
          //   Consumer<DataBase>(
          //     builder: (context, value, child) {
          //   return value.mapSearch.isEmpty && !value.errorSearch
          //       ? const Center(child: CircularProgressIndicator())
          //       : value.errorSearch
          //       ? Text(
          //     'Oops, something went wrong .${value.errorMessageSearch}',
          //     textAlign: TextAlign.center,
          //   ) : ListView.builder(
          //     physics: const ClampingScrollPhysics(),
          //
          //     shrinkWrap: true,
          //     itemCount: value.mapSearch['service_search'].length,
          //     itemBuilder: (BuildContext context, index) {
          //       if(value.mapSearch['service_search'][0]
          //       ['msg'] !=
          //           'True') {
          //         return Center(
          //           child: Container(
          //             width: double.infinity,
          //             height: 500,
          //             alignment: Alignment.center,
          //             padding:
          //             const EdgeInsets.only(top: 200),
          //             child: Text(value
          //                 .mapSearch['service_search'][0]
          //             ['msg']
          //                 .toString()),
          //           ),
          //         );
          //       }else{
          //         print('else Working');
          //
          //         return SearchCard(
          //             map: value.mapSearch['service_search']
          //             [index]);
          //       }
          //     },
          //   );
          // },
          // );
          //
          //
        },
      ),

      // Consumer<DataBase>(
      //   builder: (context,value,child){
      //     print(value.toString());
      //     return Container();
      //     },
      // ),

      //

      //
    );
  }
}

class SearchCard1 extends StatelessWidget {
  const SearchCard1({Key? key, required this.map}) : super(key: key);

  final Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DetailPage2(map: map);
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          CachedNetworkImageProvider(map['image'].toString()),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        map['city'].toString(),
                        style: GoogleFonts.ubuntu(
                            fontSize: 12.0, color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        map['name'].toString(),
                        style: GoogleFonts.ubuntu(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: Colors.black,
                          ),
                          Expanded(
                            child: Text(
                              map['area'].toString(),
                              maxLines: 1,
                              style: GoogleFonts.ubuntu(
                                  fontSize: 12.0, color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  map['phone'].toString(),
                  style: GoogleFonts.ubuntu(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
