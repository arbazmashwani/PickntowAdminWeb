import 'dart:convert';

import 'package:http/http.dart' as http;

String serverKey =
    'key=AAAAAWnrHQw:APA91bHnRSyRdSnbWoyStY1U4FUaS_BJtLFo0RG_nQxgx6I8Gm3MEB_8VNH94UukcKw1Vi7gpCWrCVEPu0cYWnaUG7Go4xx69sbeH9orRpYLE8ytzyV_aCSr9FpkYZHOB6-WKilYpVOA';

void sendPushMessage(String body, String title, String token) async {
  try {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': serverKey,
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body,
            'title': title,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          "to": token,
        },
      ),
    );
  } catch (e) {
    // ignore: avoid_print
    print("error push notification");
  }
}
