import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FillBtn extends StatelessWidget {
  final String label;
  final void Function()? onPressed;

  const FillBtn({
    required this.label,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      // final double btnHeigh = deviceType == DeviceType.mobile ? 50 : 80;

      return Container(
        // margin: EdgeInsets.only(top: 0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            elevation: MaterialStateProperty.all<double>(0),
            alignment: Alignment.center,
            fixedSize:
                MaterialStateProperty.all<Size>(const Size.fromHeight(50)),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      );
    });
  }
}
