import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataBase extends ChangeNotifier {
  String initial_city = 'Select City';
  String initial_city1 = 'Select City';

  bool isLoggedIn = false;

  Future<bool> checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await prefs.getString('id');
    if (id == '' || id == '0' || id == 0 || id == null) {
      isLoggedIn = false;
    } else {
      print(id);
      print('it just got true!');
      isLoggedIn = true;
      _getAuth();
    }
    notifyListeners();
    return isLoggedIn;
  }

  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    removeUser();
    isLoggedIn = false;
    notifyListeners();
  }

  getPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      if (await Permission.location.request().isGranted) {
        // Either the permission was already granted before or the user just granted it.
      }

// You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
      print(statuses[Permission.location]);
      getCurrentlocation();
      getCityLocation();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    } else {
      print('is not dnied');
    }
    notifyListeners();
  }

  double x = 0.0;
  double y = 0.0;

  Map<String, dynamic> _mapLogin = {};
  bool _errorLogin = false;
  String _errorMessageLogin = '';

  Map<String, dynamic> get mapLogin => _mapLogin;

  bool get errorLogin => _errorLogin;

  String get errorMessageLogin => _errorMessageLogin;

  Future<void> userLogin(String phone, String password) async {
    String completeurl =
        'https://mrworker.pk/API/loginapi.php?phone=$phone&password=$password';
    print(completeurl);
    final response = await http.get(
      Uri.parse(
          'https://mrworker.pk/API/loginapi.php?phone=$phone&password=$password'),
    );
    if (response.statusCode == 200) {
      try {
        _mapLogin = jsonDecode(response.body);
        _errorLogin = false;
        if (_mapLogin.isNotEmpty && _mapLogin['message'] == "True") {
          print('yes its true from db');
          print(_mapLogin['user'][0]['id'].toString());
          id = _mapLogin['user'][0]['id'].toString();
          name = _mapLogin['user'][0]['name'].toString();
          phone = _mapLogin['user'][0]['phone'].toString();
          image = _mapLogin['user'][0]['image'].toString();
          addAuth(id, name, email, password, phone, image);
        }
      } catch (e) {
        _errorLogin = true;
        _errorMessageLogin = e.toString();
        _mapLogin = {};
      }
    } else {
      _errorLogin = true;
      _errorMessageLogin = 'Error : It could be your Internet connection.';
      _mapLogin = {};
    }
    notifyListeners();
  }

  Map<String, dynamic> _mapRegister = {};
  bool _errorRegister = false;
  String _errorMessageRegister = '';

  Map<String, dynamic> get mapRegister => _mapRegister;

  bool get errorRegister => _errorRegister;

  String get errorMessageRegister => _errorMessageRegister;

  Future<void> userRegister(String name, String email, String password,
      String phone, String image) async {
    String completeurl =
        'https://mrworker.pk/API/registrationapi.php?name=$name&email=$email&password=$password&phone=$phone&image=$image';
    print(completeurl);
    final response;

    // var response = await http.get(
    //   Uri.parse(completeurl),
    // );
    if (Profilepicture != null) {
      String base64Image = base64Encode(Profilepicture!.readAsBytesSync());
      String fileName = Profilepicture!.path.split("/").last;
      print('${Profilepicture}picture printing');

      response = await http.post(Uri.parse(completeurl), body: {
        "image": base64Image,
        "name": fileName,
      });
      if (response.statusCode == 200) {
        print("${response.body}  printing mapregister");

        try {
          _mapRegister = jsonDecode(response.body);
          print(_mapRegister.toString());
          _errorRegister = false;
          if (_mapRegister.isNotEmpty && _mapRegister['message'] == "True") {
            print(
                'yes its true from db and following is printing user object.');
            id = _mapRegister['user']['id'];
            name = _mapRegister['user']['name'].toString();
            email = _mapRegister['user']['email'].toString();
            phone = _mapRegister['user']['phone'].toString();
            image = _mapRegister['user']['image'].toString();
            print(_mapRegister.toString());
            addAuth(id, name, email, password, phone, image);
          }
        } catch (e) {
          _errorRegister = true;
          _errorMessageRegister = e.toString();
          _mapRegister = {};
        }
      } else {
        _errorRegister = true;
        _errorMessageRegister = 'Error : It could be your Internet connection.';
        _mapRegister = {};
      }
    }

    notifyListeners();
  }

  Map<String, dynamic> mapUserRegister = {};

  Map<String, dynamic> get _mapUserRegister => mapUserRegister;

  Future<void> uploadImage(
    String name,
    String email,
    String password,
    String phone,
    String Bio,
    String speciality,
    String fb_link,
    String whatsapp,
    String city,
  ) async {
    String URL =
        'https://mrworker.pk/API/registrationapi.php?name=$name&email=$email&password=$password&phone=$phone&about=$Bio&speciality=$speciality&city=$city&facebook=$fb_link&whatsapp=$whatsapp';
    print(URL);
    final response;
    response = await http.post(Uri.parse(URL));
    print("printing responce$response");

    if (response.statusCode == 200) {
      mapUserRegister = jsonDecode(response.body);
      print('prinitng From Map$mapUserRegister');
      print('its 200');
      print(response.body.toString());

      id = _mapRegister['user']['id'];
      name = _mapRegister['user']['name'].toString();
      email = _mapRegister['user']['email'].toString();
      phone = _mapRegister['user']['phone'].toString();
      image = _mapRegister['user']['image'].toString();
      print(_mapRegister.toString());
      addAuth(id, name, email, password, phone, image);
      print('${id}printing id');

      var abPost = jsonDecode(response.body);
      print('${abPost}ab post');
      print('ab ye jae ga Login py');
      notifyListeners();
    }
  }

  var id;
  String name = '';
  String email = '';
  String phone = '';
  String password = '';
  String image = '';

  void _getAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    name = prefs.getString('name') ?? '';
    email = prefs.getString('email') ?? '';
    password = prefs.getString('password') ?? '';
    email = prefs.getString('email') ?? '';
    id = prefs.getString('id') ?? '';
    phone = prefs.getString('phone') ?? '';
    image = prefs.getString('image') ?? '';

    notifyListeners();
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("password");
    prefs.remove("image");
    prefs.remove("phone");
    notifyListeners();
  }

  void addAuth(id, name, email, password, phone, image) async {
    print(id + ' id is being printed');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', id);

    prefs.setString('name', name);
    prefs.setString('email', email);
    prefs.setString('password', password);
    prefs.setString('phone', phone);
    prefs.setString('image', image);
    print('auth added ');
    notifyListeners();
  }

  Future<String> getImage() async {
    _getAuth();

    return image;
  }

  Future<String> getName() async {
    _getAuth();
    return name;
  }

  Future<String> getEmail() async {
    _getAuth();
    // notifyListeners();
    return email;
  }

  // var city ;
  Map<String, dynamic> _mapLocation = {};
  bool _errorLocation = false;
  String _errorMessageLocation = '';

  Map<String, dynamic> get mapLocation => _mapLocation;

  bool get errorLocation => _errorLocation;

  String get errorMessageLocation => _errorMessageLocation;

  Future<void> Getlocation(String lat, String lng) async {
    // String completeurl = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=' +
    //     lat+',' + lng+'&key=AIzaSyA_LoRMvCG3IiIXtGcEybX6eyd0ijKFZAw&sensor=false';
    // print(completeurl);
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyA_LoRMvCG3IiIXtGcEybX6eyd0ijKFZAw&sensor=false'));

    if (response.statusCode == 200) {
      try {
        _mapLocation = jsonDecode(response.body);
        print(_mapLocation.toString());

        _errorLocation = false;
        if (_mapLocation.isNotEmpty) {
          getCityLocation();

          // addlocation( lat , lng);

        }
      } catch (e) {
        _errorLocation = true;
        _errorMessageLocation = e.toString();
        _mapLocation = {};
      }
    } else {
      _errorLocation = true;
      _errorMessageLocation = 'Error : It could be your Internet connection.';
      _mapLocation = {};
    }
    notifyListeners();
  }

  late Map<double, dynamic> map;

  void getCurrentlocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    x = await position.latitude;
    y = await position.longitude;
    Getlocation(x.toString(), y.toString());
    print('${lastPosition}last position');
    notifyListeners();
  }

  var Cityname = null ?? 'Select City';

  getCityName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Cityname = prefs.getString('Cityname') ?? '';
    Cityname = initial_city;
    notifyListeners();
    return Cityname = prefs.getString('Cityname') ?? '';
  }

  Future<void> getCityLocation() async {
    var gotten_city = await _mapLocation['results'][0]['address_components'][5]
            ['long_name']
        .toString();
    Cityname = gotten_city;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Cityname', Cityname);
    Cityname = prefs.getString('Cityname') ?? '';
    print('printing city name$Cityname');
    SetCityForSearchbar(Cityname.toString());

    notifyListeners();
  }

  final ImagePicker imagePicker = ImagePicker();

  List<XFile>? imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);

      notifyListeners();
    }
  }

  File? Profilepicture;

  Future setProfileImage(img) async {
    Profilepicture = img;

    print('Profile picture Updating');

    notifyListeners();
  }

  File? ProjectImage;

  Future setProjectImage(img) async {
    ProjectImage = img;

    print('Project Image Updating');

    notifyListeners();
  }

  Map<String, dynamic> _mapPopular = {};
  bool _errorPopular = false;
  String _errorMessagePopular = '';

  Map<String, dynamic> get mapPopular => _mapPopular;

  bool get errorPopular => _errorPopular;

  String get errorMessagePopular => _errorMessagePopular;

  Future<void> get fetchPopular async {
    final response = await http.get(
      Uri.parse('https://mrworker.pk/API/popular'),
    );
    if (response.statusCode == 200) {
      try {
        _mapPopular = jsonDecode(response.body);
        _errorPopular = false;
      } catch (e) {
        _errorPopular = true;
        _errorMessagePopular = e.toString();
        _mapPopular = {};
      }
    } else {
      _errorPopular = true;
      _errorMessagePopular = 'Error : It could be your Internet connection.';
      _mapPopular = {};
    }
    notifyListeners();
  }

  Map<String, dynamic> _mapCategory = {};
  bool _errorCategory = false;
  String _errorMessageCategory = '';

  Map<String, dynamic> get mapCategory => _mapCategory;

  bool get errorCategory => _errorCategory;

  String get errorMessageCategory => _errorMessageCategory;

  Future<void> get fetchCategory async {
    final response = await http.get(
      Uri.parse('https://mrworker.pk/API/categories.php'),
    );

    if (response.statusCode == 200) {
      try {
        _mapCategory = jsonDecode(response.body);
        _errorCategory = false;
      } catch (e) {
        _errorCategory = true;
        _errorMessageCategory = e.toString();
        _mapCategory = {};
      }
    } else {
      _errorCategory = true;
      _errorMessageCategory = 'Error : It could be your Internet connection.';
      _mapCategory = {};
    }
    notifyListeners();
  }

  Map<String, dynamic> _mapSearch = {};
  bool _errorSearch = false;
  String _errorMessageSearch = '';

  Map<String, dynamic> get mapSearch => _mapSearch;

  bool get errorSearch => _errorSearch;

  String get errorMessageSearch => _errorMessageSearch;

  Future<void> Search(String curl, String city) async {
    final response = await http.get(
      Uri.parse('https://mrworker.pk/API/search?city=$city&type_tag=$curl'),
    );
    if (response.statusCode == 200) {
      try {
        _mapSearch = jsonDecode(response.body);
        _errorSearch = false;
      } catch (e) {
        _errorSearch = true;
        _errorMessageSearch = e.toString();
        _mapSearch = {};
      }
    } else {
      _errorSearch = true;
      _errorMessageSearch = 'Error : It could be your Internet connection.';
      _mapSearch = {};
    }

    notifyListeners();
    // return _mapSearch;
  }

  Map<String, dynamic> _mapRecommendation = {};
  bool _errorRecommendation = false;
  String _errorMessageRecommendation = '';

  Map<String, dynamic> get mapRecommendation => _mapRecommendation;

  bool get errorRecommendation => _errorRecommendation;

  String get errorMessageRecommendation => _errorMessageRecommendation;

  Future<void> get fetchRecommendation async {
    final response = await http.get(
      Uri.parse('https://mrworker.pk/API/search.php'),
    );
    if (response.statusCode == 200) {
      try {
        _mapRecommendation = jsonDecode(response.body);
        _errorRecommendation = false;
      } catch (e) {
        _errorRecommendation = true;
        _errorMessageRecommendation = e.toString();
        _mapRecommendation = {};
      }
    } else {
      _errorRecommendation = true;
      _errorMessageRecommendation =
          'Error : It could be your Internet connection.';
      _mapRecommendation = {};
    }
    notifyListeners();
  }

  String selectedvalue = ' Select Category';

  Map<String, dynamic> _mapProjects = {};
  bool _errorProjects = false;
  String _errorMessageProjects = '';

  Map<String, dynamic> get mapProjects => _mapProjects;

  bool get errorProjects => _errorProjects;

  String get errorMessageProjects => _errorMessageProjects;

  Future<void> fetchProjects(user_id) async {
    final response = await http.get(
      Uri.parse('https://mrworker.pk/API/projects?user_id=' + user_id),
    );
    print('https://mrworker.pk/API/projects?user_id=' + user_id);
    if (response.statusCode == 200) {
      try {
        _mapProjects = jsonDecode(response.body);
        print(_mapProjects);
        _errorProjects = false;
      } catch (e) {
        _errorProjects = true;
        _errorMessageProjects = e.toString();
        _mapProjects = {};
      }
    } else {
      _errorProjects = true;
      _errorMessageProjects = 'Error : It could be your Internet connection.';
      _mapProjects = {};
    }
    notifyListeners();
  }

  void setCategory(city) async {
    selectedvalue = city.toString();
    notifyListeners();
  }

  String selectedCity = 'Select City';

  void setCity(city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String selectedCity = (prefs.getString('initial_city') ?? 'islamabad');
    selectedCity = city.toString();
    notifyListeners();
  }

  Future<String> SetCityForSearchbar(city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    await prefs.setString('city', city);
    // String stringValue = (prefs.getString('initial_city') ?? 'Islamabad');
    initial_city = city.toString();
    notifyListeners();
    return initial_city;
  }

  Future<String> SetCityForSearchbar1(city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    await prefs.setString('city', city);
    // String stringValue = (prefs.getString('initial_city') ?? 'Islamabad');
    initial_city1 = city.toString();
    notifyListeners();
    return initial_city1;
  }

  Future<String> getCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = await (prefs.getString('city') ?? 'Islamabad');
    initial_city = stringValue;
    notifyListeners();
    return initial_city;
  }

  Map<String, dynamic> _mapSearch1 = {};
  bool _errorSearch1 = false;
  String _errorMessageSearch1 = '';

  Map<String, dynamic> get mapSearch1 => _mapSearch1;

  bool get errorSearch1 => _errorSearch1;

  String get errorMessageSearch1 => _errorMessageSearch1;

  Future<void> Search1(String curl, String city) async {
    final response = await http.get(
      Uri.parse('https://mrworker.pk/API/search?city=$city&type_tag=$curl'),
    );
    if (response.statusCode == 200) {
      try {
        _mapSearch1 = jsonDecode(response.body);
        _errorSearch1 = false;
      } catch (e) {
        _errorSearch1 = true;
        _errorMessageSearch1 = e.toString();
        _mapSearch1 = {};
      }
    } else {
      _errorSearch1 = true;
      _errorMessageSearch1 = 'Error : It could be your Internet connection.';
      _mapSearch1 = {};
    }

    notifyListeners();
  }

  Map<String, dynamic> _mapViewmore = {};
  bool _errorViewmore = false;
  String _errorMessageViewmore = '';

  Map<String, dynamic> get mapViewmore => _mapViewmore;

  bool get errorViewmore => _errorViewmore;

  String get errorMessageViewmore => _errorMessageViewmore;

  Future<void> get ViewAll async {
    final response = await http.get(
      Uri.parse('https://mrworker.pk/API/view_more_users.php'),
    );
    if (response.statusCode == 200) {
      try {
        _mapViewmore = jsonDecode(response.body);
        _errorViewmore = false;
      } catch (e) {
        _errorViewmore = true;
        _errorMessageViewmore = e.toString();
        _mapViewmore = {};
      }
    } else {
      _errorViewmore = true;
      _errorMessageViewmore = 'Error : It could be your Internet connection.';
      _mapViewmore = {};
    }
    notifyListeners();
  }

  Map<String, dynamic> _mapEmergency_Search = {};
  bool _errorEmergency_Search = false;
  String _errorMessageEmergency_Search = '';

  Map<String, dynamic> get mapEmergency_Search => _mapEmergency_Search;

  bool get errorEmergency_Search => _errorEmergency_Search;

  String get errorMessageEmergency_Search => _errorMessageEmergency_Search;

  Future<void> Emergency_Search(String city) async {
    final response = await http.get(Uri.parse(
        'https://mrworker.pk/API/emergency_services.php?' + 'city=' + city));
    if (response.statusCode == 200) {
      try {
        _mapEmergency_Search = jsonDecode(response.body);
        print('Printing emergency services$_mapEmergency_Search');
        _errorEmergency_Search = false;
      } catch (e) {
        _errorEmergency_Search = true;
        _errorMessageEmergency_Search = e.toString();
        _mapEmergency_Search = {};
      }
    } else {
      _errorEmergency_Search = true;
      _errorMessageEmergency_Search =
          'Error : It could be your Internet connection.';
      _mapEmergency_Search = {};
    }
    notifyListeners();
  }

  Map<String, dynamic> _mapUserDetail = {};
  bool _errorUserDetail = false;
  String _errorMessageUserDetail = '';

  Map<String, dynamic> get mapUserDetail => _mapUserDetail;

  bool get errorUserDetail => _errorUserDetail;

  String get errorMessageUserDetail => _errorMessageUserDetail;

  Future<void> UserDetail(user_id) async {
    final response = await http.get(
      Uri.parse('https://mrworker.pk/API/user_detail?user_id=' + user_id),
    );
    if (response.statusCode == 200) {
      try {
        _mapUserDetail = jsonDecode(response.body);
        print(_mapUserDetail);
        _errorUserDetail = false;
      } catch (e) {
        _errorUserDetail = true;
        _errorMessageUserDetail = e.toString();
        _mapUserDetail = {};
      }
    } else {
      _errorUserDetail = true;
      _errorMessageUserDetail = 'Error : It could be your Internet connection.';
      _mapUserDetail = {};
    }
    notifyListeners();
  }

  Map<String, dynamic> _mapNew = {};
  bool _errorNew = false;
  String _errorMessageNew = '';

  Map<String, dynamic> get mapNew => _mapNew;

  bool get errorNew => _errorNew;

  String get errorMessageNew => _errorMessageNew;

  Future<void> userNew(
      {required String name,
      required String profileImage,
      required String email,
      required String password,
      required String about,
      required String phone,
      required String speciality,
      required String city,
      required String area,
      required String whatsapp,
      required String fb_link}) async {
    String completeurl =
        'https://mrworker.pk/API/registrationapi.php?name=$name&email=$email&password=$password&about=$about&phone=$phone&speciality=$speciality&city=$city&area=$area&whatsapp=$whatsapp&fb_link=$fb_link';
    print(completeurl);
    if (Profilepicture != null) {
      String base64Image = base64Encode(Profilepicture!.readAsBytesSync());
      String fileName = Profilepicture!.path.split("/").last;
      print('${Profilepicture}picture printing');

      var response = await http.post(Uri.parse(completeurl), body: {
        "profileImage": base64Image,
        "name": fileName,
      });

      // if(response.body != ''){
      //   print('this is being called');
      //   print(response.body.toString());
      // }else{
      //   print('response body is empty');
      // }

      if (response.statusCode == 200) {
        try {
          _mapNew = jsonDecode(response.body);

          print('printing map');
          print(_mapNew.toString());
          _errorNew = false;
          if (_mapNew.isNotEmpty && _mapNew['message'] == "True") {
            print('yes its true from db');
            print(_mapNew['user'][0]['id'].toString());
            id = _mapNew['user'][0]['id'].toString();
            name = _mapNew['user'][0]['name'].toString();
            phone = _mapNew['user'][0]['phone'].toString();
            image = _mapNew['user'][0]['image'].toString();
            addAuth(id, name, email, password, phone, image);
          }
        } catch (e) {
          _errorLogin = true;
          _errorMessageLogin = e.toString();
          _mapLogin = {};
        }
      } else {
        _errorLogin = true;
        _errorMessageLogin = 'Error : It could be your Internet connection.';
        _mapLogin = {};
      }
      notifyListeners();
    }
  }

  Map<String, dynamic> _mapAddproject = {};
  bool _errorAddproject = false;
  String _errorMessageAddproject = '';

  Map<String, dynamic> get mapAddproject => _mapAddproject;

  bool get errorAddproject => _errorAddproject;

  String get errorMessageAddproject => _errorMessageAddproject;

  Future<void> Addproject({
    required String user_id,
    required String title,
  }) async {
    String completeurl = 'https://mrworker.pk/API/add_project?';
    if (ProjectImage != null) {
      String base64Image = base64Encode(ProjectImage!.readAsBytesSync());
      String fileName = ProjectImage!.path.split("/").last;
      print('$ProjectImage project image printing');

      var response = await http.post(Uri.parse(completeurl), body: {
        "image": base64Image,
        'user_id': user_id,
        'title': title,
        "name": fileName,
      });
      print(response.body.toString());

      if (response.statusCode == 200) {
        print('Status is 200');
        print("${response.body}printing responce");
        try {
          _mapAddproject = jsonDecode(response.body);

          print('printing map');
          print(_mapAddproject.toString());
          _errorAddproject = false;
          if (_mapAddproject.isNotEmpty &&
              _mapAddproject['message'] == "True") {
            print('yes its true from db');
          }
        } catch (e) {
          _errorAddproject = true;
          _errorMessageAddproject = e.toString();
          _mapAddproject = {};
        }
      } else {
        _errorAddproject = true;
        _errorMessageAddproject =
            'Error : It could be your Internet connection.';
        _mapAddproject = {};
      }
      notifyListeners();
    }
  }

  Map<String, dynamic> _mapAddprojectGallery = {};
  bool _errorAddprojectGallery = false;
  String _errorMessageAddprojectGallery = '';

  Map<String, dynamic> get mapAddprojectGallery => _mapAddprojectGallery;

  bool get errorAddprojectGallery => _errorAddprojectGallery;

  String get errorMessageAddprojectGallery => _errorMessageAddprojectGallery;

  Future<void> AddprojectGallery({
    required String project_id,
  }) async {
    String completeurl = 'https://mrworker.pk/API/add_gallery_images?';
    for (var i = 0; i < imageFileList!.length; i++) {
      print(i.toString());
      File? galleryimage = File(imageFileList![i].path);

      print(galleryimage);

      String base64Image = base64Encode(galleryimage.readAsBytesSync());
      print('${base64Image}base64');
      String fileName = galleryimage.path.split("/").last;
      print('$galleryimage project image printing');

      var response = await http.post(Uri.parse(completeurl), body: {
        "image": base64Image,
        "name": fileName,
        'project_id': project_id,
      });
      if (response.statusCode == 200) {
        print(response.statusCode.toString());
        print(response.body);
      }
    }
    notifyListeners();
  }

  String remove_project = '';

  Future<void> removeProject(project_id) async {
    String completeurl =
        'https://mrworker.pk/API/remove_project?project_id=' + project_id;
    var response = await http.post(Uri.parse(completeurl), body: {
      'project_id': project_id,
    });
    if (response.statusCode == 200) {
      remove_project = response.body[0];
    }
    notifyListeners();
  }

  String remove_gallery_image = '';

  Future<void> removeGalleryImage(image_id) async {
    String completeurl =
        'https://mrworker.pk/API/remove_image?image_id=' + image_id;
    var response = await http.post(Uri.parse(completeurl), body: {
      'image_id': image_id,
    });
    if (response.statusCode == 200) {
      remove_gallery_image = response.body[0];
    }
    notifyListeners();
  }

  void initialValues() {
    _mapRegister = {};
    _errorRegister = false;
    _errorMessageRegister = '';
    _mapLogin = {};
    _errorLogin = false;
    _errorMessageLogin = '';
    getCurrentlocation();
    _mapPopular = {};
    _errorMessagePopular = '';
    _errorPopular = false;
    _mapCategory = {};
    _errorMessageCategory = '';
    _errorCategory = false;
    _mapSearch = {};
    _errorSearch = false;

    _errorMessageSearch = '';
    _mapEmergency_Search = {};
    _errorEmergency_Search = false;

    _errorMessageEmergency_Search = '';

    notifyListeners();
  }

//for search city

  bool isTyping = false;

  void searchData(String text) {
    if (text.isNotEmpty) {
      isTyping = true;
      notifyListeners();
    }
    notifyListeners();
  }
}
