class DefResponse {
  bool success;
  dynamic data;
  String? message;

  DefResponse({
    required this.success,
    this.data,
    this.message
  });

  factory DefResponse.fromJson(Map<String, dynamic> json) {
    return DefResponse(
      success: json['success'] ?? false,
      data: json['data'],
      message: json['message'] != null ? json['message'].toString() : "",
    );
  }
}