

import 'package:dropili/core/services/safe_convert.dart';

class DeleteBlockResponse {
  final bool success;
  final String message;

  DeleteBlockResponse({
    this.success = false,
    this.message = "",
  });

  factory DeleteBlockResponse.fromJson(Map<String, dynamic>? json) => DeleteBlockResponse(
    success: asBool(json, 'success'),
    message: asString(json, 'message'),
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
  };
}

