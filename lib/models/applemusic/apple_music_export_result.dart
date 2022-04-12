
class AppleMusicExportResult {
  AppleMusicExportResult({
    this.data,
    required this.success,
    required this.message
  });
  final String? data;
  final bool success;
  final String message;

  factory AppleMusicExportResult.fromJson(Map<String, dynamic> json){
    final data = json.containsKey('data') ? json['data'] : "";
    final success = json['success'];
    final message = json['message'];
    return AppleMusicExportResult(
      data: data,
      success: success,
      message: message,
    );
  }
}