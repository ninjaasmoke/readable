class Voice {
  Voice({
    required this.name,
    required this.locale,
  });
  late final String name;
  late final String locale;

  Voice.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    locale = json['locale'];
  }

  Map<String, String> toJson() {
    final _data = <String, String>{};
    _data['name'] = name;
    _data['locale'] = locale;
    return _data;
  }
}
