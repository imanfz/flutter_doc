abstract class BaseModel {
  fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}

class sam extends BaseModel {
  String code;
  String message;
  String data;

  sam({required this.code, required this.message, required this.data});

  @override
  fromJson(Map<String, dynamic> json) {
    return sam(
        code: json['code'], message: json['message'], data: json['data']);
  }

  @override
  Map<String, dynamic> toJson() {
    return Map.from({'code': code, 'message': message, 'data': data});
  }
}
