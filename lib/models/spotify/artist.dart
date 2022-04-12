class Artist {
  Artist({required this.name, required this.href});
  final String name;
  final String href;

  factory Artist.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final href = json['href'];
    return Artist(name: name, href: href);
  }

    Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['href'] = href;
    return _data;
  }

}