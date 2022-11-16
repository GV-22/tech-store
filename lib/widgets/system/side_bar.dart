import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_app/models/order_entity.dart';
import 'package:responsive_app/models/product_entitty.dart';
import 'package:responsive_app/provider/ui_provider.dart';
import 'package:responsive_app/utils/event_bus_controller.dart';
import 'package:responsive_app/utils/helpers.dart';
import 'package:responsive_app/utils/types.dart';
import 'package:responsive_app/utils/ui.dart';
import 'package:responsive_app/widgets/cart/cart.dart';
import 'package:responsive_app/widgets/notifications.dart';
import 'package:responsive_app/widgets/order/checkout.dart';
import 'package:responsive_app/widgets/order/order_viewer.dart';
import 'package:responsive_app/widgets/order/payment_completed.dart';
import 'package:responsive_app/widgets/products/product_viewer.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  /// the side bar content, only tablet
  Widget? _sideBarContent;
  SideBarContentType? _sideBarContentType;
  late StreamSubscription<EventData> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = EventBusController.eventBus.on<EventData>().listen((event) {
      _listenerHandler(event);
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _updateSideBarState(
    Widget? widget, {
    SideBarContentType? contentType,
  }) async {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    if (widget == null) {
      setState(() {
        _sideBarContent = null;
        _sideBarContentType = null;
      });
      uiProvider.setSideBarState(false);
      return;
    }

    uiProvider.setSideBarState(true);
    // it the sidebar was closed, refresh with empty content and...
    if (_sideBarContent == null) {
      setState(() => _sideBarContent = const SizedBox());
    }
    // ...wait while the animated container is animating
    await Future.delayed(const Duration(milliseconds: 400));
    setState(() {
      _sideBarContentType = contentType;
      _sideBarContent = widget;
    });
  }

  void _listenerHandler(EventData event) {
    // print("EVENT $event");
    switch (event.cause) {
      case EventCause.viewProductDetails:
        final data = event.data;
        if (data is! ProductEntity) {
          throw ArgumentError(
              "Invalid data provided to view product details. => $data");
        }
        // await _setSidebarContent(ProductViewer(data));
        _updateSideBarState(
          ProductViewer(data),
          contentType: SideBarContentType.product,
        );

        break;
      case EventCause.viewCart:
        if (_sideBarContentType == SideBarContentType.cart) {
          // close the cart
          _updateSideBarState(null);
        } else {
          _updateSideBarState(
            const Cart(),
            contentType: SideBarContentType.cart,
          );
        }
        break;
      case EventCause.viewNotifications:
        if (_sideBarContentType == SideBarContentType.notifications) {
          // close notifications
          _updateSideBarState(null);
        } else {
          _updateSideBarState(
            const Notifications(),
            contentType: SideBarContentType.notifications,
          );
        }
        break;
      case EventCause.viewCheckout:
        _updateSideBarState(
          const Checkout(),
          contentType: SideBarContentType.checkout,
        );
        break;
      case EventCause.paymentCompleted:
        _updateSideBarState(
          const PaymentCompleted(),
          contentType: SideBarContentType.paymentCompleted,
        );
        break;
      case EventCause.viewOrder:
        final data = event.data;
        if (data is! OrderEntity) {
          throw ArgumentError(
              "Invalid data provided to view order details. => $data");
        }
        _updateSideBarState(
          OrderViewer(data),
          contentType: SideBarContentType.order,
        );
        break;
      case EventCause.closeSideBar:
        _updateSideBarState(null);
        break;

      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = getDeviceSize(context).width;
    final double sideBarWidth = _sideBarContent == null ? 0 : screenWidth * .30;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: _sideBarContent == null ? 0 : sideBarWidth,
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(width: 2, color: grey100Color)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => _updateSideBarState(null),
            icon: const Icon(Icons.close_rounded),
          ),
          if (_sideBarContent != null) Expanded(child: _sideBarContent!)
        ],
      ),
    );
  }
}
