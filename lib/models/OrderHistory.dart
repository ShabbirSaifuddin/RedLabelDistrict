import 'Order.dart';

class OrderHistory {
  final int id;
  final String date, amount, address, status;
  final List<Order> products;

  OrderHistory(
      {required this.id,
      required this.date,
      required this.amount,
      required this.address,
      required this.products,
      required this.status});
}

// Demo data for our cart

List<OrderHistory> demoHistory = [];
