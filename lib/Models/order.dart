
class Order {
  final String date;
  final String? status;
  var id;
  final String location;
  List products;
  Order(
      {required this.location,
      required this.date,
      this.status,
      required this.id,
      required this.products});
}
