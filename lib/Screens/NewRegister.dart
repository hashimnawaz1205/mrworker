import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mrworker/AppState/database.dart';
import 'package:mrworker/Screens/Login.dart';
import 'package:provider/provider.dart';
import 'Api/user_api.dart';

class RegisterNew extends StatelessWidget {
  RegisterNew({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  String photo = '';

  final TextEditingController _typeAheadController = TextEditingController();
  final TextEditingController _typeAheadController2 = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController Areacontroller = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController AboutController = TextEditingController();
  var img = '';

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map;
    String message;
    var dbclass = context.read<DataBase>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Register",
          style: GoogleFonts.ubuntu(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                height: 150,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Signup & Join Team over 54,000 Workers",
                            style: GoogleFonts.montserrat(
                                fontSize: 22.0,
                                color: Theme.of(context).primaryColor),
                          ),
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
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Image(
                              fit: BoxFit.contain,
                              image: AssetImage('assets/logo.png'),
                            ) //BoxDecoration
                            ),
                      ), //Container
                    )
                  ],
                ),
              ),
              // InkWell(
              //   onTap: () async {
              //     var pickedFile = await ImagePicker()
              //         .pickImage(source: ImageSource.gallery);

              // dbclass.setProfileImage(File(pickedFile!.path));
              //   },
              //   child: Consumer<DataBase>(builder: (context, value, child) {
              //     return value.Profilepicture != null
              //         ? SizedBox(
              //             width: double.infinity,
              //             height: 150,
              //             child: CircleAvatar(
              //               child: ClipOval(
              //                 child: Image.file(
              //                   value.Profilepicture!,
              //                   fit: BoxFit.cover,
              //                   width: 150,
              //                 ),
              //               ),
              //             ),
              //           )
              //         : Stack(
              //             alignment: Alignment.center,
              //             children: [
              //               const SizedBox(
              //                 width: double.infinity,
              //                 height: 200,
              //                 child: CircleAvatar(
              //                   backgroundImage: NetworkImage(
              //                       "https://cdn2.vectorstock.com/i/1000x1000/17/61/male-avatar-profile-picture-vector-10211761.jpg"),
              //                 ),
              //               ),
              //               Container(
              //                 width: 100,
              //                 height: 40,
              //                 decoration: BoxDecoration(
              //                   color: Colors.black38,
              //                   borderRadius: BorderRadius.circular(18),
              //                   border: Border.all(color: Colors.black),
              //                 ),
              //                 child: Padding(
              //                   padding: const EdgeInsets.only(left: 16.0),
              //                   child: Row(
              //                     mainAxisAlignment: MainAxisAlignment.start,
              //                     children: const [
              //                       Text(
              //                         'Edit',
              //                         style: TextStyle(color: Colors.white),
              //                       ),
              //                       Icon(
              //                         Icons.edit,
              //                         color: Colors.white,
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //               )
              //             ],
              //           );
              //   }),
              // ),

              Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Register',
                    style: GoogleFonts.ubuntu(
                        fontSize: 25.0,
                        color: Theme.of(context).secondaryHeaderColor),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Name ';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      labelText: 'Complete Name',
                      labelStyle: GoogleFonts.ubuntu(
                          color: Theme.of(context).primaryColor)),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: phoneController,
                  validator: (value) {
                    if (value == null || value.length < 11) {
                      return 'Please Enter Valid Phone Number';
                    }
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Phone',
                      labelStyle: GoogleFonts.ubuntu(
                          color: Theme.of(context).primaryColor)),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  controller: passController,
                  validator: (value) {
                    if (value == null || value.length < 7) {
                      return 'Password character lenght should be atleast 7';
                    }
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                      labelText: 'Password',
                      labelStyle: GoogleFonts.ubuntu(
                          color: Theme.of(context).primaryColor)),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TypeAheadFormField<City?>(
                  hideSuggestionsOnKeyboardHide: false,
                  textFieldConfiguration: TextFieldConfiguration(
                    enableSuggestions: false,
                    autofocus: false,
                    controller: this._typeAheadController2,
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.ubuntu(
                          color: Theme.of(context).primaryColor),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12)),
                      focusedBorder: InputBorder.none,
                      hintText: 'City',
                    ),
                  ),
                  suggestionsCallback: UserApi1.getCitySuggestions,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter City Name';
                    }
                  },
                  itemBuilder: (context, City? suggestion) {
                    final city = suggestion!;

                    return ListTile(
                      title: Text(
                        city.name,
                        style: GoogleFonts.ubuntu(
                            color: Theme.of(context).primaryColor),
                      ),
                    );
                  },
                  noItemsFoundBuilder: (context) => const SizedBox(
                    height: 10,
                    child: Center(
                      child: Text(
                        'No City Found.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  onSuggestionSelected: (City? suggestion) {
                    final city = suggestion!;

                    this._typeAheadController2.text = city.name.toString();
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  controller: Areacontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter valid Area Address';
                    }
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      labelText: 'Area',
                      labelStyle: GoogleFonts.ubuntu(
                          color: Theme.of(context).primaryColor)),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TypeAheadFormField<Category?>(
                    hideSuggestionsOnKeyboardHide: false,
                    textFieldConfiguration: TextFieldConfiguration(
                      enableSuggestions: false,
                      controller: this._typeAheadController,
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.ubuntu(
                            color: Theme.of(context).primaryColor),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor)),
                        hintText: 'Category',
                      ),
                    ),
                    suggestionsCallback: UserApi2.getCategorySuggestions,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Category ';
                      }
                    },
                    itemBuilder: (context, Category? suggestion) {
                      final user = suggestion!;

                      return ListTile(
                        title: Text(
                          user.name,
                          style: GoogleFonts.ubuntu(
                              color: Theme.of(context).primaryColor),
                        ),
                      );
                    },
                    noItemsFoundBuilder: (context) => SizedBox(
                      child: Center(
                        child: Text(
                          'No Category Found.',
                          style: GoogleFonts.ubuntu(fontSize: 16),
                        ),
                      ),
                    ),
                    onSuggestionSelected: (Category? suggestion) {
                      final user = suggestion!;

                      this._typeAheadController.text = user.name.toString();
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  onChanged: (value) =>
                      EmailValidator.validate(value.toString())
                          ? null
                          : "Please enter a valid email.",
                  validator: (value) =>
                      EmailValidator.validate(value.toString())
                          ? null
                          : "Please enter a valid email.",
                  controller: emailController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      labelText: 'Email',
                      labelStyle: GoogleFonts.ubuntu(
                          color: Theme.of(context).primaryColor)),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: whatsappController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.length < 11) {
                      return 'Please Enter valid Whatsapp Number';
                    }
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple)),
                    labelText: 'Whatsapp',
                    labelStyle: GoogleFonts.ubuntu(
                        color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter facebook link';
                    }
                  },
                  controller: facebookController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Facebook Link',
                      labelStyle: GoogleFonts.ubuntu(
                          color: Theme.of(context).primaryColor)),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter About';
                    }
                  },
                  controller: AboutController,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'About',
                      labelStyle: GoogleFonts.ubuntu(
                          color: Theme.of(context).primaryColor)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFa51b1f),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var name = nameController.text.toString();
                      var email = emailController.text.toString();
                      var Bio = AboutController.text.toString();
                      var password = passController.text.toString();
                      var phone = phoneController.text.toString();
                      var speciality = _typeAheadController.text.toString();
                      var city = _typeAheadController2.text.toString();
                      var area = Areacontroller.text.toString();
                      var whatsapp = whatsappController.text.toString();
                      var fb_link = facebookController.text.toString();
                      var image = photo.toString();
                      print('photo' + image);
                      await dbclass.userNew(
                          name: name,
                          profileImage: image,
                          email: email,
                          password: password,
                          about: Bio,
                          phone: phone,
                          speciality: speciality,
                          city: city,
                          area: area,
                          whatsapp: whatsapp,
                          fb_link: fb_link);

                      // await dbclass.userNew( name,image, email, password, Bio, phone, speciality, city, area, whatsapp, fb_link);
                      map = dbclass.mapNew;
                      message = dbclass.mapNew['message'].toString();
                      print(message);
                      print('printing user');
                      print(dbclass.mapNew['user'].toString());
                      //checking map if its empty or shit
                      if (map.isEmpty) {
                        print('map is empty');

                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Warning', style: GoogleFonts.ubuntu()),
                            content: FutureBuilder(
                              future: dbclass.userNew(
                                  name: name,
                                  profileImage: image,
                                  email: email,
                                  password: password,
                                  about: Bio,
                                  phone: phone,
                                  speciality: speciality,
                                  city: city,
                                  area: area,
                                  whatsapp: whatsapp,
                                  fb_link: fb_link),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data.toString(),
                                    softWrap: true,
                                    style: GoogleFonts.ubuntu(
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
                                child: const Text('Try again'),
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
                                  builder: (BuildContext context) =>
                                      const Mylogin()));
                        } else if (message.isNotEmpty && message != 'True') {
                          print('False');
                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Warning'),
                              content: Text(message.toString()),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop(); // dismisses only the dialog and returns nothing
                                  },
                                  child: const Text('Try again'),
                                ),
                              ],
                            ),
                          );
                        }
                      }

                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login & Best of luck')),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Register',
                      style: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.w500, fontSize: 18.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
