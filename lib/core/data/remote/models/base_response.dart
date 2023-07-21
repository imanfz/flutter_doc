class BaseResponse<T> {
  bool? status;
  String? code;
  String? message;
  T? data;

  BaseResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory BaseResponse.fromJson(
      Map<String, dynamic> json, Function(Map<String, dynamic>) parse) {
    return BaseResponse<T>(
      status: json['status'],
      code: json['code'] ?? json['status_code'],
      message: json['message'] ?? json['status_message'],
      data: parse(json['data'] ?? json['result']),
    );
  }
}

class BaseListResponse<T> {
  bool? status;
  String? code;
  String? message;
  List<T?>? data;

  BaseListResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory BaseListResponse.fromJson(
      Map<String, dynamic> json, Function(Map<String, dynamic>) parse) {
    return BaseListResponse<T>(
      status: json['status'],
      code: json['code'] ?? json['status_code'],
      message: json['message'] ?? json['status_message'],
      data: (json['data'] ?? json['result']).map((e) => parse(e)).toList(),
    );
  }
}
