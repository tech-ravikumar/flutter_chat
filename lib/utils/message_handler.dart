import 'package:flutter/cupertino.dart';

import '../widget/top_snackbar/top_snack_bar.dart';


class AppMessageHandler {
  static final AppMessageHandler _singleton = AppMessageHandler._internal();

  factory AppMessageHandler() {
    return _singleton;
  }

  AppMessageHandler._internal();

  void showSnackBar(BuildContext context, MessageType? messageType) {
    const _duration = Duration(milliseconds: 800);
    if (messageType != null) {
      if (messageType.type == 'success') {
        showTopSnackBar(
          context,
          CustomSnackBar.success(message: messageType.message),
          showOutAnimationDuration: _duration,
          hideOutAnimationDuration: _duration,
          displayDuration: const Duration(milliseconds: 1500),
        );
      } else if(messageType.type == 'info') {
        showTopSnackBar(
          context,
          CustomSnackBar.info(message: messageType.message),
          showOutAnimationDuration: _duration,
          hideOutAnimationDuration: _duration,
          displayDuration: const Duration(milliseconds: 1500),
        );
      } else {
        showTopSnackBar(
          context,
          CustomSnackBar.error(message: messageType.message),
          showOutAnimationDuration: _duration,
          hideOutAnimationDuration: _duration,
          displayDuration: const Duration(milliseconds: 1500),
        );
      }
    }
  }
}

class MessageType {
  final String message;
  final String type;

  const MessageType(this.message, this.type);

  const MessageType.success(this.message) : type = 'success';

  const MessageType.error(this.message) : type = 'error';

  const MessageType.info(this.message) : type = 'info';
}

