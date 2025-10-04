class Quiz {
  final String? des, title;
  String? id;
  Quiz({required this.des, required this.title, this.id});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(des: json["description"], title: json["title"]);
  }
}
