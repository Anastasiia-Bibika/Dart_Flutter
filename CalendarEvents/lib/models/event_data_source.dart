import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:calendarevents/models/event.dart';
class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> appointments) {
    this.appointments = appointments;
  }

  Event getEvent(int index) => appointments![index] as Event;

  @override
  DateTime getStartTime(int index) {
    final Event event = getEvent(index);
    if (event.starttime != null) {
      return DateTime.parse(event.date.toString() + " " + event.starttime!);
    }
    // Return some default value if starttime is null or date is null
    return DateTime.now();
  }

  @override
  DateTime getEndTime(int index) {
    final Event event = getEvent(index);
    if (event.endtime != null) {
      return DateTime.parse(event.date.toString() + " " + event.endtime!);
    }
    // Return some default value if endtime is null or date is null
    return DateTime.now();
  }

  @override
  String getSubject(int index) {
    return getEvent(index).title;
  }
}