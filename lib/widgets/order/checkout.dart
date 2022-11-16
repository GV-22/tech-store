import 'package:clickable_widget/clickable_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_app/provider/user_provider.dart';
import 'package:responsive_app/screens/payment_completed_screen.dart';
import 'package:responsive_app/utils/event_bus_controller.dart';
import 'package:responsive_app/utils/form_item.dart';
import 'package:responsive_app/utils/helpers.dart';
import 'package:responsive_app/utils/types.dart';
import 'package:responsive_app/utils/ui.dart';
import 'package:responsive_app/widgets/form/f_text_field.dart';
import 'package:responsive_app/widgets/system/fill_btn.dart';
import 'package:sizer/sizer.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  PaymentMethod _paymentMethod = PaymentMethod.paypal;
  final _formKey = GlobalKey<FormState>();
  final _deliveryAddress = FormItem.notEmpty();
  final _email = FormItem.validEmail();
  final _cardNumber = FormItem.notEmpty();
  final _expirationDate = FormItem.notEmpty();
  final _ccv = FormItem.notEmpty();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total"),
                Text(
                  "XOF ${formatNumber(userProvider.cartAmount())}",
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Pay with credit card"),
                const SizedBox(height: 24),
                FTextField(
                  formItem: _deliveryAddress,
                  inputType: TextInputType.emailAddress,
                  hintText: "Delivery address",
                ),
                const SizedBox(height: 12),
                FTextField(
                  formItem: _email,
                  inputType: TextInputType.emailAddress,
                  hintText: "email",
                ),
                const SizedBox(height: 12),
                FTextField(
                  formItem: _cardNumber,
                  inputType: TextInputType.text,
                  hintText: "Card number",
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: FTextField(
                        formItem: _expirationDate,
                        inputType: TextInputType.datetime,
                        hintText: "Exp. date",
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FTextField(
                        formItem: _ccv,
                        inputType: TextInputType.emailAddress,
                        hintText: "CCV",
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Text(
            "Or",
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _PaymentMethodCard(
                paymentMethod: PaymentMethod.paypal,
                selected: _paymentMethod == PaymentMethod.paypal,
                onChange: _onChange,
              ),
              _PaymentMethodCard(
                paymentMethod: PaymentMethod.applePay,
                selected: _paymentMethod == PaymentMethod.applePay,
                onChange: _onChange,
              ),
              // _PaymentMethodCard(
              //   paymentMethod: PaymentMethod.mastercard,
              //   selected: _paymentMethod == PaymentMethod.mastercard,
              //   onChange: _onChange,
              // ),
            ],
          ),
          SizedBox(height: 16.sp),
          FillBtn(
            label: "Pay now",
            onPressed: () {
              userProvider.addNewOrder();
              if (isMobile) {
                Navigator.of(context)
                    .pushNamed(PaymentCompletedScreen.routeName);
              } else {
                EventBusController.fireEvent(EventData(
                  cause: EventCause.paymentCompleted,
                ));
              }
            },
          )
        ],
      ),
    );
  }

  void _onChange(PaymentMethod method) {
    setState(() {
      _paymentMethod = method;
    });
  }
}

class _PaymentMethodCard extends StatelessWidget {
  final PaymentMethod paymentMethod;
  final Function(PaymentMethod paymentMethod) onChange;
  final bool selected;

  const _PaymentMethodCard({
    required this.paymentMethod,
    required this.onChange,
    this.selected = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final double size = isMobile ? 60 : 60;

    return ClickableContainer(
      width: size,
      height: size,
      margin: EdgeInsets.symmetric(horizontal: 4.sp),
      onTap: () => onChange(paymentMethod),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? colorScheme.primary : grey100Color,
      ),
      child: Icon(
        getIcon(),
        color: selected ? Colors.white : colorScheme.primary,
      ),
    );
  }

  IconData getIcon() {
    switch (paymentMethod) {
      case PaymentMethod.applePay:
        return Icons.apple_rounded;
      case PaymentMethod.paypal:
        return Icons.paypal_rounded;

      case PaymentMethod.mastercard:
      default:
        return Icons.credit_card_rounded;
    }
  }
}
