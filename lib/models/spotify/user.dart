
class User {
  final String name;
  final String type;
  final String id;
  User({required this.id, required this.name, required this.type});

  factory User.fromJson(Map<String, dynamic> json) {
    // if (json == null) return null;
    final name = json['display_name'];
    final type = json['type'];
    final id = json['id'];
    return User(name: name, type: type, id: id);
  }

  Map<String, dynamic> toJson() => {
        'display_name': name,
        'id': id,
        'type': type,
      };

}