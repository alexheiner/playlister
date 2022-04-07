

class Token {
  final int expires_in;
  final String token_type;
  final String access_token;
  Token(this.access_token, this.token_type,this.expires_in);

  factory Token.fromJson(Map<String, dynamic> json){
    final token_type = json['token_type'];
    final expires_in = json['expires_in'];
    final access_token = json['access_token'];
    return Token(access_token, token_type, expires_in);
  }

  Map<String, dynamic> toJson() => {
    'expires_in': expires_in,
    'token_type': token_type,
    'access_token': access_token,
    // 'expires_at': expires_at,
  };


  // bool isExpired() {
  //   return DateTime.now().isBefore(this.expires_at);
  // }


  
}