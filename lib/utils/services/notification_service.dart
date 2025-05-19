import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../Services/shared_pref_service.dart';
import '../constants.dart';
import '../service_locator.dart';

class NotificationService {
  String _msg = "";
  late final fCMToken;
  var sharedPref = locator<SharedPrefService>();
  final _firebaseMessaging = FirebaseMessaging.instance;
  final StreamController<String> _messageController = StreamController<String>.broadcast();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  String get msg => _msg;
  Stream<String> get messageStream => _messageController.stream;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    if (Platform.isAndroid) {
      fCMToken = await _firebaseMessaging.getToken();
      await _firebaseMessaging.subscribeToTopic("all");
    } else {
      try {
        fCMToken = await _firebaseMessaging.getToken();
      } catch (e) {
        print('Error getting FCM Token, trying APNs Token instead.');
        fCMToken = await _firebaseMessaging.getAPNSToken();
      }
    }

    /// store in shared-pref
    sharedPref.saveToSharedPref(fcmToken, fCMToken);

    /// listen for messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              "channelId1",
              "channelName",
              channelDescription: "channelDescription",
              playSound: true,
              priority: Priority.max,
              importance: Importance.high,
              icon: "@mipmap/ic_launcher",
            ),
            iOS: DarwinNotificationDetails(
              presentSound: true,
              presentAlert: true,
              presentBadge: true,
            ),
          ),
        );
      }

      if (message.notification != null) {
        print('NOTIFICATION :: Message notification: ${message.notification!.body}');
        extractOTP(message);
      }
    });
  }

  /// Use a regular expression to capture the OTP from the end of the message
  void extractOTP(RemoteMessage message) async {
    var messageBody = message.notification!.body!;

    RegExp regExp = RegExp(r'\d{6}$'); // Matches the last 6 digits
    var match = regExp.firstMatch(messageBody);

    if (match != null) {
      _msg = match.group(0)!;
      print('NOTIFICATION :: OTP: $_msg');
      _messageController.add(msg);
    }
  }
}
