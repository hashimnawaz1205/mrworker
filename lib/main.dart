import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrworker/AppState/database.dart';
import 'package:mrworker/Screens/Splash.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'Services/PushNotificationService.dart';
import 'firebase_options.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(const MyApp());
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final pushNotificationService = PushNotificationService(_firebaseMessaging);
    pushNotificationService.initialise();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => DataBase(),
            builder: (context, child) {
              return MaterialApp(
                title: 'Mr.Worker',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: const Color(0xFFECEDEE),
                    primary: const Color(0xFFECEDEE), //<-- SEE HERE
                  ),
                  backgroundColor: const Color(0xFFF5F6F6),
                  primaryColor: const Color(0xFFa51b1f),
                  secondaryHeaderColor: const Color(0xFFa51b1f),
                  // accentColor: const Color(0xFFFE9936),
                  accentColor: const Color(0xFFa51b1f),
                  textTheme: TextTheme(
                    headline1: const TextStyle(
                      color: Color(0xFFa51b1f),
                    ),
                    bodyText1: TextStyle(
                      color: const Color(0xFFa51b1f).withOpacity(0.5),
                    ),
                  ),
                  primaryTextTheme: GoogleFonts.ubuntuCondensedTextTheme(),
                ),
                home: const Splash(),
              );
            }),
      ],
    );
  }
}
