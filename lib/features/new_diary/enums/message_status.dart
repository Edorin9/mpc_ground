import 'package:flutter/material.dart';

enum MessageStatus { none, regular, success, failure }

extension MessageStatusExt on MessageStatus {
  Color? get color {
    switch (this) {
      case MessageStatus.regular:
        return Colors.black;
      case MessageStatus.success:
        return Colors.green;
      case MessageStatus.failure:
        return Colors.red;
      case MessageStatus.none:
        return null;
    }
  }
}
