import 'package:flutter/material.dart';
import 'package:responsive_app/models/order_entity.dart';
import 'package:responsive_app/utils/helpers.dart';
import 'package:responsive_app/utils/ui.dart';

class OrderViewer extends StatelessWidget {
  final OrderEntity order;

  const OrderViewer(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order N°${to2Digits(order.id)}"),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Ordered at",
                style: TextStyle(color: grey400Color),
              ),
              Text(
                formatDate(order.orderedAt, "d MMMM yyyy"),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Delivery date",
                style: TextStyle(color: grey400Color),
              ),
              Text(
                formatDate(order.deliveryDate, "d MMMM yyyy"),
              ),
            ],
          ),
          const SizedBox(height: 48),
          Table(
            columnWidths: const {
              0: FractionColumnWidth(.5),
              1: FractionColumnWidth(.2),
              2: FractionColumnWidth(.3),
            },
            children: [
              TableRow(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.blue, width: 1),
                  ),
                ),
                children: [
                  _tableHead(value: "Label", context: context),
                  _tableHead(value: "Qt", context: context),
                  _tableHead(
                      value: "Amount", context: context, alignRight: true),
                ],
              ),
              ...order.items
                  .map(
                    (item) => TableRow(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: grey300Color, width: 1),
                        ),
                      ),
                      children: [
                        _tableData(item.product.label),
                        _tableData(to2Digits(item.quantity)),
                        _tableData(formatNumber(item.amount), alignRight: true),
                      ],
                    ),
                  )
                  .toList(),
              _tableFooter(context)
            ],
          )
        ],
      ),
    );
  }

  TableCell _tableHead({
    required String value,
    required BuildContext context,
    bool alignRight = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          value,
          textAlign: alignRight ? TextAlign.right : TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: colorScheme.primary,
          ),
        ),
      ),
    );
  }

  TableRow _tableFooter(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const style = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

    return TableRow(
      decoration: BoxDecoration(color: colorScheme.primary),
      children: [
        const TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Total", style: style),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(to2Digits(order.quantity), style: style),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text("XOF ${formatNumber(order.amount)}", style: style),
            ),
          ),
        ),
      ],
    );
  }

  TableCell _tableData(String value, {bool alignRight = false}) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          value,
          textAlign: alignRight ? TextAlign.right : TextAlign.start,
          style: const TextStyle(),
        ),
      ),
    );
  }
}
