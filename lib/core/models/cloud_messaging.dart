// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:chat_app/core/models/chat_user_model.dart';
import 'package:chat_app/features/setting/logic/get_user_cubit/get_user_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class PushNotificationService {
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "chat-app-dc500",
      "private_key_id": "562fab8daaa427cefd7c72f4a2bdacc6a2881fd5",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC/8/54Cf/8N4sz\nfSkkLKXOuXm2aQ31rt2ln942A+bfjAOzDBRzF36i0+yjkptJKBGh2Y4HpfU/xGzA\nvwJgB4IxCQt8FiqIf1qV2p2QZbqa5diPbMxdKN0oMrTQF7ZeUxLq3aFEgq3t4J9W\nqnhD8FGZexq71OUof4xESpcaUulQvA8dP1t1nQ6SYqpgO4YOHxk2nFR0JXKM7K+W\nO7wMLMiw4OzJ8pfbTffwhFpN81FckBHgaKGEqT+IOW7cLXIPY+UadBWntYudGFSz\nfNiNLeatWXcBWNRj1gh51zBRV2e24jPs5yGbhGPkROCcdzWsLBlDZgFWAKV5FXip\nwO+VUn85AgMBAAECggEAE2xVkgD1Caj3KXEfQh1Qc9AZzEbqFjOpEvLP0ehoKrOo\nxivRP+ofMsu99LlHhEoNKrLwZ763x8mQ9Zn+XAg2eM7A/j/h8ujsGiDCc9OPY9Ah\nLzYjocOaSVCEMlBL8FR4pBJkGKIehmUFyoe6XqmJID4wMNR0kboCUAC6NHwyRqxr\n+1gV7k9VEikfejTRgyzqMemMVndWITmlHeoatAZyIXSaq+qdF5lQZgwhke5LwuLe\nxQdgO2qHXdOwlOsxEpgmhF5scBckzlAmuLWFrUwfwQv79EAFWrDxcOiQvIlqSbGg\nonRBmsgN3VrNmOb6HkIvsKch9JvQzZuTQHKXowEeuQKBgQDkW7MJDFvEZg6dW0DH\nK6uhMELzQzfI8J5de8mQbcdggzJOX/WJ4MLqPUXbbmN51jln9kndaZsaGR5QHXPM\nYcP+wFF2/ndBr9ureSZkInoFJUSDje43GliQaDtK1yUA+1aX4bl7xGqpkHN1y/dU\nsgKbTtpT19tOrJYRerjuNcKelQKBgQDXMC78rS/xJ0h25YGPddK/Y+o66kH4G9KL\nVLWqD1g3wQXqgEB0yo/+sE8hFVeH9KSx6M1SVFovOcDoLLJGM0zlz5bOC+k6y7Yb\nU4lWt+EGpHJBhITSfnZNjXfud9EgfTQo3dexzk/iEsijA28ksrvNQNpAT/cnOQlW\n2n7OBtdJFQKBgF0mHqDJPsGdU8bSS1kzMh5dHmI2gBHiPOcrMGxOq25t9d5MfE8S\ntM9x0QYSQFeZj+8dYsIDavY5WskZSnwLQTSwZEqiwCi2QGfw0j00ZwukSQ9UnOAz\nSf8V1WHQ4tJEs+zecZfP5iZmuwJJAgm1VyTdBGgA+/9anRhiM/9PRKUFAoGAYFcN\nIkjzRtcchUaZK75HXTKBYmEQqeDi8Ug6kOmPyF5dpLBIq0EpGJCczKX+azrnJVOh\n4PMs8Sm9KPUh13YOPnEjBhqlD5K2dCOBQFbQoyWqlZSb1pWRp4Tnpdb0xMPpP0aa\n09sXPpLESt81ukte8zTOwa5La78IZF8sGFdNuUUCgYBmAFZ/YGEq2ovzMjR9WL4K\nr//66p9wqAKIOXBascRRYiW7mIkuA6h6/m8WEzN32y796jKrKfQXvN3Y3+36ZyZ2\n/I1FJ+WTsw2oM7FOsvto7McS6dO+sM3HGcsY+9fQ7zmoRv9bDY1oLclDGxC5j/l7\nRTh81IR3Ip825u84GRQO/Q==\n-----END PRIVATE KEY-----\n",
      "client_email": "chat-app-dc500@appspot.gserviceaccount.com",
      "client_id": "101019225091109337900",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/chat-app-dc500%40appspot.gserviceaccount.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    try {
      final http.Client client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
        scopes,
      );

      final auth.AccessCredentials credentials =
          await auth.obtainAccessCredentialsViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
        scopes,
        client,
      );

      client.close();
      return credentials.accessToken.data;
    } catch (e) {
      log('Failed to obtain access token: $e');
      rethrow;
    }
  }

  static sendNotificationToAdmin({
    required ChatUserModel chatUser,
    required BuildContext context,
    required String messageBody,
    String? groupName,
  }) async {
    final String serverAccessTokenKey = await getAccessToken();
    String endPointFirebaseCloudMessaging =
        'https://fcm.googleapis.com/v1/projects/chat-app-dc500/messages:send';

    final Map<String, dynamic> message = {
      'message': {
        'token': chatUser.puchToken,
        'notification': {
          'title': groupName == null
              ? context.read<GetUserCubit>().me!.name
              : '$groupName : ${context.read<GetUserCubit>().me!.name}',
          'body': messageBody
        },
        'data': {}
      }
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(endPointFirebaseCloudMessaging),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $serverAccessTokenKey'
        },
        body: jsonEncode(message),
      );

      log('Server Access Token: $serverAccessTokenKey');
      log('Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        log('Notification sent successfully');
      } else {
        log('Failed to send notification: ${response.statusCode}');
      }
    } catch (e) {
      log('Error sending notification: $e');
    }
  }
}
