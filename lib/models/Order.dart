class Order {
  int product_id;
  int quantity;

  Order({required this.product_id, required this.quantity});

  Map toJson() => {
        'product_id': product_id,
        'quantity': quantity,
      };
}

// Demo data for our cart

List<Order> ListItems = [];
