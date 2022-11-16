import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_app/provider/store_provider.dart';
import 'package:responsive_app/provider/ui_provider.dart';
import 'package:responsive_app/provider/user_provider.dart';
import 'package:responsive_app/screens/auth/singin_screen.dart';
import 'package:responsive_app/screens/cart_screen.dart';
import 'package:responsive_app/screens/checkout_screen.dart';
import 'package:responsive_app/screens/main_board.dart';
import 'package:responsive_app/screens/notifications_screen.dart';
import 'package:responsive_app/screens/order_details_screen.dart';
import 'package:responsive_app/screens/payment_completed_screen.dart';
import 'package:responsive_app/screens/product_details_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (ctx) => StoreProvider()),
            ChangeNotifierProvider(create: (ctx) => UserProvider()),
            ChangeNotifierProvider(create: (ctx) => UiProvider()),
          ],
          child: MaterialApp(
            title: 'Store - Responsive App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: "Poppins",
              primarySwatch: Colors.blue,
              colorScheme: const ColorScheme.light(
                primary: Colors.blue,
                secondary: Colors.blue,
              ),
              iconTheme: const IconThemeData(color: Colors.blue),
            ),
            home: const SignInScreen(),
            // home: const MainBoard(),
            routes: {
              MainBoard.routeName: (context) => const MainBoard(),
              ProductDetailsScreen.routeName: (context) =>
                  const ProductDetailsScreen(),
              CartScreen.routeName: (context) => const CartScreen(),
              NotificationsScreen.routeName: (context) =>
                  const NotificationsScreen(),
              CheckoutScreen.routeName: (context) => const CheckoutScreen(),
              PaymentCompletedScreen.routeName: (context) =>
                  const PaymentCompletedScreen(),
              OrderDetailsScreen.routeName: (context) =>
                  const OrderDetailsScreen(),
            },
          ),
        );
      },
    );
  }
}
