class CategoriesModel {
  final int id;
  final String name;
  final String image;

  CategoriesModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoriesModel.fromJSON(Map<dynamic, dynamic> json) {
    return CategoriesModel(
      id: json['id'],
      name: json['name'],
      image: json['image']['src'],
    );
  }

  void printvalues() {
    print("id  " + id.toString());
    print("name  " + name.toString());
    print("image  " + image.toString());
  }
}
