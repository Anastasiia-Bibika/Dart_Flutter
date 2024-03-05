import 'package:calendarevents/models/event.dart';
import 'package:calendarevents/screens/add_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(_selectedDate != null
                ? _selectedDate!.toIso8601String().substring(0, 10)
                : "All Events"),
            if (_selectedDate != null)
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _selectedDate = null;
                  });
                },
              )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2035),
                );
                if (newDate != null) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                }
              },
              icon: Icon(Icons.calendar_today))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddEventScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
