import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:weider/core/routes.dart';
import 'package:weider/core/theme/app_colors.dart';
import 'package:weider/main.dart';

import '../../features/user/data/models/user_model/user_model.dart';

class NotificationPrepared {
  NotificationPrepared._();
  static FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  static void onNotificationTap(NotificationResponse notificationResponse) {
    final payload = notificationResponse.payload;

    if (payload != null) {
      // You can handle deep navigation here
      log("Notification payload: $payload");

      // Example: use a navigation key to open a screen
      navigatorKey.currentState?.pushNamed(Screens.home, arguments: payload);
    }
  }

  static void askPermissions() {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()!
        .requestNotificationsPermission();
  }

  static init() {
    plugin.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      ),
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
      onDidReceiveNotificationResponse: onNotificationTap,
    );
  }

  static Future<void> showOneAlarm({required String title, required String body}) async {
    await plugin.show(
      DateTime.now().microsecond,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          "subscription",
          "Subscription",
          priority: Priority.max,
          importance: Importance.max,
          fullScreenIntent: true,
          groupKey: "Sub_end",
          groupAlertBehavior: GroupAlertBehavior.all,
          category: AndroidNotificationCategory.reminder,
          color: AppColors.secondary,
          colorized: true,
          showWhen: true,
          channelShowBadge: true,
          audioAttributesUsage: AudioAttributesUsage.alarm,
          
        ),
      ),
    );
  }

  static Future<void> showScheduleNotification({
    required UserModel user,
    Duration? durationFromEnd,
  }) async {
    if (user.endDate.compareTo(DateTime.now()) > 0) {
      plugin.zonedSchedule(
        DateTime.now().microsecond,
        "انتهاء الاشتراك",
        "${user.name} اشتراكه اقترب علي الانتهاء",
        tz.TZDateTime.from(
          user.endDate.subtract(durationFromEnd ?? Duration(days: 3)),
          tz.getLocation("Africa/Cairo"),
        ),
        NotificationDetails(
          android: AndroidNotificationDetails(
            "subscription",
            "Subscription",
            priority: Priority.high,
            importance: Importance.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.alarmClock,
      );
    } else {
      showOneAlarm(title: "انتهي اشتراك \"${user.name}\"", body: "\"${user.name}\" انتهي اشتراكه في تاريخ ${user.endDate.toString().split(' ')[0]}");
    }
  }

  static Future<void> testSchedule({required UserModel user}) async {
    await plugin.zonedSchedule(
      1,
      "انتهاء الاشتراك",
      "${user.name} اشتراكه اقترب علي الانتهاء",
      tz.TZDateTime.from(
        DateTime.now().add(Duration(minutes: 2)),
        tz.getLocation("Africa/Cairo"),
      ),
      NotificationDetails(
        android: AndroidNotificationDetails("subscription", "Subscription"),
      ),
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }
}
