

class Token {
  final int expires_in;
  final String token_type;
  final String access_token;
  final DateTime expires_at;
  Token(this.access_token, this.token_type,this.expires_in, this.expires_at);

  factory Token.fromJson(Map<String, dynamic> json){
    final token_type = json['token_type'];
    final expires_in = json['expires_in'];
    final access_token = json['access_token'];
    DateTime exp = DateTime.now();
    DateTime time = exp.add(Duration(minutes: expires_in));
    return Token(access_token, token_type, expires_in, time);
  }

  static Token? tryFromJson(dynamic json){
    try {
      return Token.fromJson(json);
    } catch (_) {
      return null;
    }
  }


  Map<String, dynamic> toJson() => {
    'expires_in': expires_in,
    'token_type': token_type,
    'access_token': access_token,
    // 'expires_at': expires_at,
  };


  bool isExpired() {
    return DateTime.now().isBefore(this.expires_at);
  }


  
}