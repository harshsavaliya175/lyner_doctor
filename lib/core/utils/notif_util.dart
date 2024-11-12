import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtil {
  NotificationUtil._();

  static String channelId = 'com.app.job_minder_365';
  static String uploadChannelId = 'com.app.job_minder_365.upload_image';
  static String channelName = 'jobminder365 Notification';
  static String uploadChannelName = 'jobminder365 Upload Image Notification';
  static String channelDesc =
      'This will notify when images uploaded in an event, other people added in an event and how much time is remain in upload image in an event.';
  static String uploadChannelDesc =
      'This will notify while uploading an images with total uploaded image and total upload count.';
  static final _localNotifications = FlutterLocalNotificationsPlugin();

  static FlutterLocalNotificationsPlugin instance() => _localNotifications;

  static Future<void> initializePlatformNotifications() async {
    _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_notification');

    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {
        onDidReceiveLocalNotification(payload);
      },
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse? payload) {
        onDidReceiveLocalNotification(payload);
      },
      // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    //   Map<String, dynamic>? notification = message.data;
    //   dev.log(json.encode(message.data), name: 'NOTIFICATION_DATA');
    //
    //   if (notification.isNotEmpty) {
    //     if (box.read(AppConstant.userLoginData) != null) {
    //       if (box.read('currentRoute') == '/home') {
    //         HomeController homeController = Get.find();
    //         homeController.activeEvents.clear();
    //         homeController.activeEventPage = 1;
    //         await homeController.getActiveEvents(1, homeController.eventLimit);
    //
    //         homeController.pastEvents.clear();
    //         homeController.pastEventPage = 1;
    //         await homeController.getPastEvents(1, homeController.eventLimit);
    //
    //         await homeController.getNotificationCount();
    //       }
    //       if (box.read('currentRoute') == '/myGallery' ||
    //           box.read('currentRoute') == '/activeGallery' ||
    //           box.read('currentRoute') == '/pastGallery') {
    //         HomeController homeController = Get.find();
    //         homeController.getNotificationCount();
    //       }
    //
    //       showLocalNotification(
    //           id: notification.hashCode,
    //           title: notification['title'] ?? '',
    //           body: notification['body'] ?? '',
    //           payload: notification.toString());
    //     }
    //   }
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   dev.log(json.encode(message.data), name: 'NOTIFICATION_ON_TAP_DATA');
    //   Get.toNamed(RouteManager.notification);
    // });
  }

  static sendDownloadNotification(
    String title,
    String body, {
    bool? sound,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "freeme_channel",
      "FreeMe",
      playSound: sound ?? false,
      enableVibration: sound ?? false,
      channelAction: AndroidNotificationChannelAction.values.first,
      color: Colors.black,
      priority: Priority.max,
      showProgress: true,
    );

    DarwinNotificationDetails iosNotificationDetail = DarwinNotificationDetails(
      presentAlert: sound ?? false,
      presentSound: sound ?? false,
      presentBadge: sound ?? false,
      interruptionLevel: InterruptionLevel.active,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetail,
    );

    await _localNotifications.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  static Future<void> initializeBGNotifications() async {
    _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_notification');

    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(initializationSettings);
  }

  static Future<void> showProgressBarNotification(int id, String title,
      String content, int progress, int maxProgress) async {
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDesc,
      channelShowBadge: false,
      importance: Importance.high,
      priority: Priority.high,
      onlyAlertOnce: true,
      showProgress: true,
      maxProgress: maxProgress,
      progress: progress,
      autoCancel: true,
      playSound: false,
      enableVibration: false,
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await _localNotifications.show(
      id,
      title,
      content,
      platformChannelSpecifics,
    );
  }

  static void onDidReceiveLocalNotification(dynamic payload) {
    if (payload != null) {
      // Get.toNamed(RouteManager.notification);
    }
  }

  static Future<void> showLocalNotification(
      {required int id,
      required String title,
      required String body,
      required String payload}) async {
    final platformChannelSpecifics = await _notificationDetails(
        channelId: channelId,
        channelName: channelName,
        channelDesc: channelDesc);
    await _localNotifications.show(id, title, body, platformChannelSpecifics,
        payload: payload);
  }

  static Future<void> showUploadNotification({
    required int notificationId,
    required String notificationTitle,
    required String notificationBody,
  }) async {
    final platformChannelSpecifics = await _notificationDetails(
        channelId: uploadChannelId,
        channelName: uploadChannelName,
        channelDesc: uploadChannelDesc,
        sound: false,
        vibration: false,
        onlyAlertOnce: true);
    await _localNotifications.show(notificationId, notificationTitle,
        notificationBody, platformChannelSpecifics,
        payload: '');
  }

  static Future<NotificationDetails> _notificationDetails(
      {required String channelId,
      required String channelName,
      required String channelDesc,
      bool sound = true,
      bool vibration = true,
      bool showProgress = false,
      bool onlyAlertOnce = false,
      int progress = 0,
      int maxProgress = 0}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(channelId, channelName,
            channelDescription: channelDesc,
            importance: Importance.max,
            priority: Priority.max,
            playSound: sound,
            color: Colors.transparent,
            showProgress: showProgress,
            icon: '@drawable/ic_notification',
            progress: progress,
            maxProgress: maxProgress,
            onlyAlertOnce: onlyAlertOnce,
            enableVibration: vibration);

    await _localNotifications.getNotificationAppLaunchDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(presentSound: sound),
    );

    return platformChannelSpecifics;
  }
}
