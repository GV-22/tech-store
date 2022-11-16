import 'package:event_bus/event_bus.dart';
import 'package:responsive_app/utils/types.dart';


abstract class EventBusController {
  static EventBus eventBus = EventBus();

  // static void fireChronoEvent(int seconds){
  //   eventBus.fire(seconds);
  // }

  static void fireEvent(EventData event) {
    eventBus.fire(event);
  }
}

class EventData {
  final EventCause cause;
  final dynamic data;

  EventData({required this.cause, this.data});

  @override
  String toString() {
    return 'EventData(cause: $cause, data: $data)';
  }
}
