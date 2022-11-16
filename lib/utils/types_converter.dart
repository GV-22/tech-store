/// Convert a dynamic to int
int intVal(dynamic value) {
  // print("int value $value ${value.runtimeType}");
  if (value is String) return int.parse(value);
  return value is int ? value : throw "Missing int value... provided $value";
}

/// Convert a dynamic to double
double doubleVal(dynamic value) {
  // print("double value: $value runTimetype: ${value.runtimeType}");
  if (value is int) return value.toDouble();
  if (value is String) return double.parse(value);
  return value is double
      ? value
      : throw "Missing double value... provided $value";
}

/// Convert a dynamic to string
String strVal(dynamic value) {
  return value is String
      ? value
      : throw "Missing string value... provided $value";
}

/// Convert a dynamic to string
bool boolVal(dynamic value) {
  return value is bool
      ? value
      : throw "Missing boolean value... provided $value";
}

/// Convert a dynamic to string
DateTime dateVal(dynamic value) {
  return value is DateTime
      ? value
      : throw "Missing DateTime value... provided $value";
}

/// Convert a list of dynamic to list of int
List<int> listOfInt(List<dynamic> value) {
  final List<int> result = [];
  // ignore: avoid_function_literals_in_foreach_calls
  value.forEach((val) => result.add(intVal(val)));

  return result;
}

/// Convert a list of dynamic to list of double
List<double> listOfDouble(List<dynamic> value) {
  final List<double> result = [];
  // ignore: avoid_function_literals_in_foreach_calls
  value.forEach((val) => result.add(doubleVal(val)));

  return result;
}

/// Convert a list of dynamic to list of int
List<String> listOfString(List<dynamic> value) {
  final List<String> result = [];
  // ignore: avoid_function_literals_in_foreach_calls
  value.forEach((val) => result.add(strVal(val)));

  return result;
}

/// Convert a dynamic value to list of dynamic.
/// Use this function only if the value is susceptible to be a list
List<dynamic> listOfDynamic(dynamic value) {
  return value is List<dynamic>
      ? value
      : throw "Missing susceptible list value";
}
