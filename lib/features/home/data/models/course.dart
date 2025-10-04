class Course {
  final String? image, title, des;
  String? id;

  Course({
    required this.image,
    required this.title,
    required this.des,
    this.id,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      image: json["image"],
      title: json["title"],
      des: json["description"],
    );
  }
}
