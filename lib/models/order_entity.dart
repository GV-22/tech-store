import 'package:responsive_app/models/cart_item_entity.dart';
import 'package:responsive_app/models/user_entity.dart';
import 'package:responsive_app/utils/types.dart';

class OrderEntity {
  final int id;
  final List<CartItemEntity> items;
  final UserEntity orderedBy;
  OrderStatus status;
  final DateTime orderedAt;

  OrderEntity({
    required this.id,
    required this.items,
    required this.orderedBy,
    required this.orderedAt,
    this.status = OrderStatus.inProgress,
  });

  void updateStatus(OrderStatus status) {
    this.status = status;
  }

  double get amount {
    double total = 0;
    for (var item in items) {
      total += item.amount;
    }

    return total;
  }
  
  int get quantity {
    int total = 0;
    for (var item in items) {
      total += item.quantity;
    }

    return total;
  }

  DateTime get deliveryDate => orderedAt.add(const Duration(days: 4));

  @override
  String toString() {
    return 'OrderEntity(id: $id, items: $items, orderedBy: $orderedBy, '
        'orderedAt: $orderedAt, status: $status)';
  }
}
