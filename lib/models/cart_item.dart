class CartItem {
  final String id;
  final String productId;
  final String? imageUrl;
  final String name;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    this.imageUrl, // <- agora é nomeado e opcional
  });
}
