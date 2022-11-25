import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../AppState/database.dart';
import '../Api/user_api.dart';
import '../../Widgets/Details/detailpage.dart';

TextEditingController textController = TextEditingController();
String newval = textController.value.toString();

String curl = "?*";
String newSetCity = '';

class NetworkTypeAheadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dbclass = context.read<DataBase>();
    return Consumer(
      builder: (context, value, child) {
        return
            // TypeAheadField(
            //   textFieldConfiguration: TextFieldConfiguration(
            //       autofocus: true,
            //       style: DefaultTextStyle.of(context)
            //           .style
            //           .copyWith(fontStyle: FontStyle.italic),
            //       decoration: InputDecoration(border: OutlineInputBorder()),
            //       controller: textController),
            //   suggestionsCallback: UserApi.getUserSuggestions,
            //   itemBuilder: (context, User? suggestion) {
            //     final user = suggestion!;

            //     return ListTile(
            //       title: Text(user.name),
            //     );
            //   },
            //   onSuggestionSelected: (User? suggestion) {
            //     final user = suggestion!;
            //     curl = user.name.toString();

            //     if (curl.isEmpty) {
            //       // curl = "?city=" + getCity().toString();
            //       print(curl);

            //       Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (BuildContext context) => detailpage(curl: curl),
            //         ),
            //       );
            //     }
            //     if (curl.isNotEmpty) {
            //       print(curl);
            //       Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (BuildContext context) => detailpage(curl: curl),
            //         ),
            //       );
            //     }
            //   },
            // );

            Padding(
          padding: const EdgeInsets.all(8.0),
          child: TypeAheadField<User?>(
            hideSuggestionsOnKeyboardHide: false,
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: true,
              controller: textController,
              textInputAction: TextInputAction.go,
              onSubmitted: (value) async {
                dbclass.searchData(value);

                if (newval != '') {
                  curl = newval;
                  print(curl);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => detailpage(curl: curl),
                    ),
                  );
                }
              },
              decoration: InputDecoration(
                fillColor: Colors.black,
                focusColor: Colors.black,
                hintStyle: GoogleFonts.montserrat(),
                // border: InputBorder.none,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                focusedBorder: InputBorder.none,
                hintText: 'Search here ...',
              ),
            ),
            suggestionsCallback: UserApi.getUserSuggestions,
            itemBuilder: (context, User? suggestion) {
              final user = suggestion!;

              return ListTile(
                title: Text(user.name),
              );
            },
            noItemsFoundBuilder: (context) => const SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  'No Category Found.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            onSuggestionSelected: (User? suggestion) {
              final user = suggestion!;
              curl = user.name.toString();

              if (curl.isEmpty) {
                // curl = "?city=" + getCity().toString();
                print(curl);

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => detailpage(curl: curl),
                  ),
                );
              }

              if (curl.isNotEmpty) {
                print(curl);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => detailpage(curl: curl),
                  ),
                );
              }

              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text('Selected Category: ${user.name}'),
                ));
            },
          ),
        );
      },
    );
  }
}
