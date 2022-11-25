import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrworker/AppState/database.dart';
import 'package:mrworker/Screens/Login.dart';
import 'package:mrworker/Screens/Profilepage.dart';
import 'package:mrworker/Widgets/Details/DetailPage2.dart';
import 'package:mrworker/Widgets/Details/projectDetails.dart';
import 'package:provider/provider.dart';

class RightProfileIcon extends StatelessWidget {
  const RightProfileIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<DataBase>().checkAuth();
    var dbclass = context.read<DataBase>();

    if (dbclass.isLoggedIn == true) {
      print('you are logged in');
    } else {
      print('false');
    }

    return Consumer<DataBase>(builder: (context, val, child) {
      print(val.isLoggedIn);
      if (val.isLoggedIn == false) {
        return Padding(
          padding: const EdgeInsets.all(1.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Mylogin(),
                ),
              );
            },
            child: CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.black12,
              child: ClipOval(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: "https://mrworker.pk/img/avatardefault.png",
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ),
        );
      } else {
        return CircleAvatar(
          radius: 50.0,
          backgroundColor: Colors.black12,
          child: InkWell(
            onTap: () async {
              var id = dbclass.id.toString();
              print(id);
              showDialog<void>(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  return Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    //mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 50, right: 50),
                        child: Container(
                          //padding: const EdgeInsets.all(3.0),
                          width: MediaQuery.of(context).size.width * 0.45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, spreadRadius: 2),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () async {
                                  await dbclass.UserDetail(dbclass.id);
                                  Map<String, dynamic> userMap =
                                      dbclass.mapUserDetail['user_detail'][0];
                                  print(' Profile Page');
                                  Navigator.of(context).pop();
                                  print(userMap);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailPage2(
                                        map: userMap,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(FontAwesomeIcons.user,
                                          size: 16.0,
                                          color:
                                              Theme.of(context).primaryColor),
                                      Text(
                                        'Profile',
                                        style: GoogleFonts.montserrat(
                                            color: Colors.black,
                                            fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(),
                              ElevatedButton(
                                onPressed: () {
                                  var id = dbclass.id.toString();
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => profilepage(
                                        id: id,
                                      ),
                                    ),
                                  );
                                  print(' Edit Profile Page');
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(FontAwesomeIcons.edit,
                                          size: 16.0,
                                          color:
                                              Theme.of(context).primaryColor),
                                      Text(
                                        ' Edit Profile',
                                        style: GoogleFonts.montserrat(
                                            color: Colors.black,
                                            fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(),
                              ElevatedButton(
                                onPressed: () {
                                  var id = dbclass.id.toString();
                                  print(' Projects');
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProjectDetails(user_id: id),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(FontAwesomeIcons.image,
                                          size: 16.0,
                                          color:
                                              Theme.of(context).primaryColor),
                                      Text(
                                        'Projects',
                                        style: GoogleFonts.montserrat(
                                            color: Colors.black,
                                            fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(),
                              ElevatedButton(
                                onPressed: () {
                                  dbclass.removeUser();
                                  dbclass.logOut();
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(FontAwesomeIcons.lock,
                                          size: 16.0,
                                          color:
                                              Theme.of(context).primaryColor),
                                      Text(
                                        ' Logout',
                                        style: GoogleFonts.montserrat(
                                            color: Colors.black,
                                            fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
            },
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: dbclass.image,
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
            ),
          ),
        );
      }
    });
  }

  Widget popUpBox(text, context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$text',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close_rounded),
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
          // SizedBox(
          //   width: 220,
          //   height: 200,
          //   child: Container(
          //     child: Center(
          //       child: Text('123'),
          //     ),
          //   ),
          //   //here !
          // ),
        ],
      ),
    );
  }
}
