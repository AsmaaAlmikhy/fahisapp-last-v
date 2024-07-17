import "dart:developer";

import "package:firebase_core/firebase_core.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/material.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import 'package:timezone/data/latest.dart' as tzData;
import "package:timezone/timezone.dart" as tz;

import "constants.dart";

class NotificationService {
  //* class singleton
  NotificationService._onlyInstance();
  static final _shared = NotificationService._onlyInstance();
  factory NotificationService.instance() => _shared;
  // factory NotificationService.instance()=> NotificationService();
  final _notificationPlugin = FlutterLocalNotificationsPlugin();

  Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }

  Future<void> initializeFCM() async {
    // getFCM Token
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token;

    _notificationPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    //background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    //foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
      }
    });

    const androidInitializationSetting =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const iosInitializationSetting = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidInitializationSetting,
      iOS: iosInitializationSetting,
    );
    _notificationPlugin.initialize(initSettings);
    // await Future.wait([
    //   onOpenAppFCM(),
    //   messaging.getToken().then((value) {
    //     log("+++++++++++++++ notificationToken: $value +++++++++++++++++++");
    //     //* keep notificationToken for user updated
    //     token = value;
    //     Global.notificationToken = token!;
    //     // log("This is Firebase Messaging token ==>> $token");
    //   }),
    //   _notificationPlugin.initialize(initSettings),

    //   //? subscribe to firebase topics
    //   Global.fbFCMUserTopic,
    //   Global.fbFCMDriverTopic,
    // ]);
  }

  Future<void> onOpenAppFCM() async {
    //foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      showNotification(
        message.notification?.title ?? appName,
        message.notification?.body ?? newNotification,
      );

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      log('Got a message whilst in the onMessageOpenedApp!');
      log('Message data: ${message.data}');
      log('rideRequestId data: ${message.data["rideRequestId"]}');

      showNotification(
        message.notification?.title ?? appName,
        message.notification?.body ?? newNotification,
      );

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
      }
    });
  }

  // Show notification with a custom sound.
  Future showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
      // sound: RawResourceAndroidNotificationSound('notification'),
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _notificationPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'custom_payload',
    );
  }

  tz.TZDateTime _nextInstanceOfAlarm({
    required DateTime appointmentTime,
  }) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime.from(
      appointmentTime,
      tz.local,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  // Schedule daily notification with a custom sound at a specified time.
  Future<void> scheduleDailyNotificationWithSound({
    required int id,
    required String title,
    required String body,
    required Time time,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    final notificationTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    log(notificationTime.toIso8601String());

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'scheduled_channel',
      'Scheduled Notifications',
      channelDescription: 'For Scheduled notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    final x = tz.TZDateTime.from(notificationTime, tz.local);

    log("TZDateTime $x");
    log("isLocal ${x.isLocal}");
    log("timeZone ${x.timeZone}");
    log("timeZoneName ${x.timeZoneName}");
    log("location ${x.location}");

    await _notificationPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(notificationTime, tz.local),
      //? This time zone should match the device's time zone.
      platformChannelSpecifics,

      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'custom_payload',
      //? Schedule the notification to repeat every day.
      matchDateTimeComponents: DateTimeComponents.time,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> scheduleDailyNotificationsForTimePeriod({
    required int id,
    required DateTime startDate,
    required DateTime endDate,
    required TimeOfDay start,
    required TimeOfDay end,
  }) async {
    // Get today's date and the desired notification time
    tzData.initializeTimeZones();
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'scheduled_channel',
      'Scheduled Notifications',
      channelDescription: 'For Scheduled notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    // Set up the start and end of the notification range
    final DateTime startDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      start.hour,
      start.minute,
    );
    final DateTime endDateTime = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
      end.hour,
      end.minute,
    );

    // Calculate the first notification time based on the current time
    DateTime firstNotificationDateTime;
    if (now.isBefore(startDateTime)) {
      // First notification is today at the desired time
      firstNotificationDateTime =
          startDateTime.add(const Duration(seconds: 10));
    } else {
      // First notification is tomorrow at the desired time
      firstNotificationDateTime = startDateTime.add(const Duration(days: 1));
    }

    // Schedule notifications from the first notification until the end of the range
    while (firstNotificationDateTime.isBefore(endDateTime)) {
      await _notificationPlugin.zonedSchedule(
        id,
        "New Schedule",
        "You have schedule ride now",
        tz.TZDateTime.from(firstNotificationDateTime, tz.local),
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
      );
      // Schedule next notification for 24 hours later
      firstNotificationDateTime =
          firstNotificationDateTime.add(const Duration(days: 1));
    }
  }

  void scheduledNotification({
    required String channelId,
    required String chanelName,
    required int notificationId,
    required String title,
    required String body,
    required DateTime appointmentTime,
  }) {
// #2
    final androidDetail = AndroidNotificationDetails(
      channelId, // channel Id
      chanelName, // channel Name
    );

    const iosDetail = DarwinNotificationDetails();

    final noticeDetail = NotificationDetails(
      iOS: iosDetail,
      android: androidDetail,
    );
    // #4

    _notificationPlugin.zonedSchedule(
      notificationId,
      title,
      body,
      _nextInstanceOfAlarm(
        appointmentTime: appointmentTime,
      ),
      noticeDetail,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> showLocalNotification(String title, String body) async {
    const androidNotificationDetail = AndroidNotificationDetails(
      "0", // channel Id
      "general", // channel Name
    );
    const iosNotificationDetail = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(
      iOS: iosNotificationDetail,
      android: androidNotificationDetail,
    );
    await _notificationPlugin.show(0, title, body, notificationDetails);
  }

  /// Request IOS permissions
  void requestIOSPermissions() {
    _notificationPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> cancelAll() async => await _notificationPlugin.cancelAll();
  Future<void> cancel(id) async => await _notificationPlugin.cancel(id);
}
