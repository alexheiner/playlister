import 'dart:math';

import 'package:flutter/material.dart';

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

  bool isExpired() {
    return DateTime.now().isBefore(this.expires_at);
  }


  
}