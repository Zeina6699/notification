// lib/utils/notification_service.dart

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationService() {
    _initialize();
  }
Future<void> onDidReceiveBackgroundNotificationResponse()async{}
  Future<void> _initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
    );

    // Set up notification channel (only for Android 8.0 and above)
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'connectivity_channel_id', // Unique channel ID
      'Connectivity Notifications', // User-friendly channel name
      description: 'Notifications related to connectivity changes',
      importance: Importance.max,

    );

    // Create the notification channel
    await _flutterLocalNotificationsPlugin.
    resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'connectivity_channel_id', // Use the same channel ID here
      'Connectivity Notifications', // User-friendly channel name
      channelDescription: 'Notifications related to connectivity changes',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      platformChannelSpecifics,
    );
  }
}
