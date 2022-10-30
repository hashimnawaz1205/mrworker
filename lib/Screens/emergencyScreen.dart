import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrworker/AppState/database.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dbclass = context.read<DataBase>();

    return Scaffold(
      appBar: AppBar(
          title: const Text('Emergency Directory'),
          backgroundColor: const Color(0xFFEBECED),
          foregroundColor: Colors.black),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedNetworkImage(
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              imageUrl: 'https://mrworker.pk/img/emergency_services.jpeg'),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child: const Text(
              'Emergency Service in your City',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: Text('Select City'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              ListTile(
                                title: Text('Islamabad'),
                                onTap: () {
                                  dbclass.SetCityForSearchbar1('Islamabad');
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                title: Text('Lahore'),
                                onTap: () {
                                  dbclass.SetCityForSearchbar1('Lahore');
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                title: Text('Peshawar'),
                                onTap: () {
                                  dbclass.SetCityForSearchbar1('Peshawar');
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                title: Text('karachi'),
                                onTap: () {
                                  dbclass.SetCityForSearchbar1('Karachi');
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                title: Text('Quetta'),
                                onTap: () {
                                  dbclass.SetCityForSearchbar1('Quetta');
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                title: Text('Azad Kashmir'),
                                onTap: () {
                                  dbclass.SetCityForSearchbar1('Azad kashmir');
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                title: Text('Rawalpindi'),
                                onTap: () {
                                  dbclass.SetCityForSearchbar1('Rawalpindi');
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                title: Text('Abbottbad'),
                                onTap: () {
                                  dbclass.SetCityForSearchbar1('Abbottbad');
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ));
                  });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8)),
                  height: MediaQuery.of(context).size.height / 14,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer<DataBase>(
                          builder: (context, value, child) {
                            return Text(
                              dbclass.initial_city1.toString(),
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFa51b1f)),
                            );
                          },
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  )),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                var city = dbclass.initial_city1.toString();
                await dbclass.Emergency_Search(city);
              },
              child: Text(
                'Search',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: Text('Directory',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 20,
          ),
          Consumer<DataBase>(builder: (context, val, child) {
            return (val.mapEmergency_Search.isNotEmpty)
                ?
                // Text(val.mapEmergency_Search.toString())
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: val.mapEmergency_Search.length,
                    itemBuilder: (context, index) {
                      var eList = val.mapEmergency_Search;
                      if (eList['emergency_services'][index]['msg'] == 'True') {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: ListTile(
                              title: Text(
                                eList['emergency_services'][index]['name']
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              subtitle: Row(
                                children: [
                                  Icon(Icons.location_on),
                                  Text(eList['emergency_services'][index]
                                          ['city']
                                      .toString()),
                                ],
                              ),
                              trailing: InkWell(
                                  onTap: () => launch("tel:" +
                                      eList['emergency_services'][index]
                                          ['phone']),
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.blue,
                                  )),
                            ),
                          ),
                        );
                      } else if (dbclass.initial_city1 == 'Select City') {
                        return Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'City is required.',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.red),
                          ),
                        ));
                      } else {
                        return Center(
                          child: Text(eList['emergency_services'][index]['msg']
                              .toString()),
                        );
                      }
                    })
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          }),
          //
          // Consumer<DataBase>(builder: (context ,value ,child){
          //   return FutureBuilder(
          //       future: db.Emergency_Search(city),
          //       builder: (BuildContext context, AsyncSnapshot snapshot) {
          //         print("printing there is some data inside "+value.mapEmergency_Search.toString());
          //         return Text(value.mapEmergency_Search.toString());
          //
          //         // if (snapshot.hasData) {
          //         //   print('yes it has data');
          //         // } else {
          //         //   print('not shit !');
          //         //   print(curl);
          //         //   print(city);
          //         // }
          //         //
          //         // if (value.mapEmergency_Search['emergency_services'] == null) {
          //         //   return const Center(
          //         //     child: CircularProgressIndicator(
          //         //       color: Colors.black12,
          //         //       backgroundColor: Colors.black12,
          //         //     ),
          //         //   );
          //         // }
          //         //
          //         // if (value.mapEmergency_Search['emergency_services'][0]['msg'] != 'True') {
          //         //   print('its null');
          //         //   return Center(
          //         //       child: Text('Sorry there is no Emergency Service Availble  in your City'));
          //         // } else {
          //         //   return
          //         //   ListView.builder(
          //         //
          //         //       // physics: const ClampingScrollPhysics(),
          //         //       shrinkWrap: true,
          //         //       itemCount: value.mapEmergency_Search['emergency_services'].length,
          //         //       itemBuilder: (BuildContext context, index) {
          //         //         return
          //         //           Text(value.mapEmergency_Search['emergency_services']['name'].toString());
          //         //           // Emergency_detail(
          //         //           //   map: value.mapEmergency_Search['emergency_services'][index]);
          //         //       });
          //         // }
          //       }
          //   );
          //
          // })
          //
        ],
      ),
    );
  }
}

class Emergency_detail extends StatelessWidget {
  Emergency_detail({Key? key, required this.map}) : super(key: key);

  Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'Service',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    map['type'].toString(),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Icon(Icons.call),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
