import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// grey
const grey50Color = Color(0xFFF6F6F6);
const grey100Color = Color(0xFFEEEEEE);
const grey200Color = Color(0xFFE2E2E2);
const grey300Color = Color(0xFFCBCBCB);
const grey400Color = Color(0xFFAFAFAF);
const grey500Color = Color(0xFF757575);
const grey600Color = Color(0xFF545454);
const boxShadowColor = Color.fromARGB(17, 0, 0, 0);
const boxShadowColor50 = Color.fromARGB(50, 0, 0, 0);

// green
const greenColor = Color(0xFF219653);
const redColor = Color(0xFFF83515);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

InputDecoration formInputDecoration({
  String? hintText,
  Widget? suffixIcon,
  Widget? prefixIcon,
  Color color = grey100Color,
  double verticalPadding = 0.0,
}) {
  return InputDecoration(
    hintText: hintText,
    contentPadding:
        EdgeInsets.symmetric(horizontal: 12, vertical: verticalPadding),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: color),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.red),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    filled: true,
    fillColor: color,
    suffixIcon: suffixIcon,
    prefixIcon: prefixIcon == null
        ? null
        : SizedBox(width: 20, child: Center(child: prefixIcon)),
  );
}

ButtonStyle roundedButtonStyle({
  double height = 50,
}) {
  return ButtonStyle(
    // backgroundColor: MaterialStateProperty.all<Color>(),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    elevation: MaterialStateProperty.all<double>(0),
    alignment: Alignment.center,
    // textStyle: MaterialStateProperty.all<TextStyle>(
    //   isOrangeBtn ? whiteBtnTextStyle : orangeBtnTextStyle,
    // ),
    fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(26.sp)),
    // padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
    //   EdgeInsets.symmetric(vertical: 14, horizontal: 18),
    // ),
  );
}

double sp4 = 4.sp;
double sp8 = 8.sp;
double sp12 = 12.sp;
double sp16 = 16.sp;
double sp20 = 20.sp;
double sp24 = 24.sp;
double sp28 = 28.sp;
double sp32 = 32.sp;

const TextStyle whiteBtnTextStyle = TextStyle(
  fontWeight: FontWeight.w700,
  color: Colors.white,
);

TextStyle titleStyle = TextStyle(
  fontWeight: FontWeight.w700,
  color: Colors.black,
  fontSize: sp12,
);

const TextStyle blackSubTitleStyle = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 14,
  color: Colors.black,
);

const TextStyle greySubTilteStyle = TextStyle(
  color: grey400Color,
  fontSize: 12,
);

TextStyle greyTextStyle = TextStyle(
  color: grey400Color,
  fontSize: 6.sp,
);

BorderRadius borderRadius8sp = BorderRadius.circular(8.sp);

BorderSide panelBorderSide = const BorderSide(width: .2, color: grey400Color);

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

bool isMobile = SizerUtil.deviceType == DeviceType.mobile;
bool isLandscape = SizerUtil.orientation == Orientation.landscape;


void appSnackbar({
  required BuildContext context,
  required String text,
  Color? bgColor,
  SnackBarAction? action,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: bgColor,
        width: !isMobile && !isLandscape ? 50.w : 100.w,
        behavior: SnackBarBehavior.floating,
        content: Text(
          text,
          style: const TextStyle(color: Colors.white, fontFamily: "Poppins"),
        ),
        duration: const Duration(milliseconds: 2500),
        action: action,
      ),
    );
}
