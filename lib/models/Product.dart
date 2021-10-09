class Product {
  final int id;
  final List<dynamic> categoryId;
  final String name, description, shortDescription, price, salePrice, rating;
  final List<dynamic> images;
  final bool isFavourite, isSale;

  Product({
    required this.id,
    required this.categoryId,
    required this.images,
    required this.name,
    required this.rating,
    required this.isFavourite,
    required this.isSale,
    required this.shortDescription,
    required this.price,
    required this.description,
    required this.salePrice,
  });

  factory Product.fromJSON(Map<dynamic, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      shortDescription: json['short_description'],
      price: json['price'],
      salePrice: json['sale_price'],
      rating: json['average_rating'],
      images: json['images'],
      isFavourite: json['featured'],
      isSale: json['on_sale'],
      categoryId: json['categories'],
    );
  }
}

// Our demo Products

// List<Product> demoProducts = [
//   Product(
//     id: 1,
//     images: [
//       "assets/images/ps4_console_white_1.png",
//       "assets/images/ps4_console_white_2.png",
//       "assets/images/ps4_console_white_3.png",
//       "assets/images/ps4_console_white_4.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Wireless Controller for PS4™",
//     price: 64.99,
//     description: description,
//     rating: 4.8,
//     isFavourite: true,
//     isPopular: true,
//   ),
//   Product(
//     id: 2,
//     images: [
//       "assets/images/Image Popular Product 2.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Nike Sport White - Man Pant",
//     price: 50.5,
//     description: description,
//     rating: 4.1,
//     isPopular: true,
//   ),
//   Product(
//     id: 3,
//     images: [
//       "assets/images/glap.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Gloves XC Omega - Polygon",
//     price: 36.55,
//     description: description,
//     rating: 4.1,
//     isFavourite: true,
//     isPopular: true,
//   ),
//   Product(
//     id: 4,
//     images: [
//       "assets/images/wireless headset.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Logitech Head",
//     price: 20.20,
//     description: description,
//     rating: 4.1,
//     isFavourite: true,
//   ),
// ];

// const String description =
//     "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
