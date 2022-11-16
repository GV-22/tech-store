import 'package:flutter/material.dart';
import 'package:responsive_app/screens/main_board.dart';
import 'package:responsive_app/utils/event_bus_controller.dart';
import 'package:responsive_app/utils/types.dart';
import 'package:responsive_app/utils/ui.dart';
import 'package:responsive_app/widgets/system/fill_btn.dart';

class PaymentCompleted extends StatelessWidget {
  const PaymentCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Thanks!"),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.credit_score_rounded, size: 120),
                SizedBox(height: 24),
                Text("Your order had successfully added!")
              ],
            ),
          ),
          FillBtn(
            label: "View your orders",
            onPressed: () {
              if (isMobile) {
                Navigator.of(context, rootNavigator: true)
                    .pushNamedAndRemoveUntil(
                  MainBoard.routeName,
                  (route) => false,
                );
              } else {
                EventBusController.fireEvent(EventData(
                  cause: EventCause.closeSideBar,
                ));
              }
              EventBusController.fireEvent(EventData(
                cause: EventCause.openSpecificBoard,
                data: 2, // FIXME use enum instead of int
              ));
            },
          )
        ],
      ),
    );
  }
}
