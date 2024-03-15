import 'package:calendarevents/models/event.dart';
import 'package:calendarevents/screens/add_event_screen.dart';
import 'package:calendarevents/screens/edit_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          Icon(
            Icons.person,
            size: 20,
          ),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: _selectedDate == null
            ? FirebaseFirestore.instance.collection('events').snapshots()
            : FirebaseFirestore.instance
                .collection('events')
                .where('date', isEqualTo: _selectedDate)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error fetching data: ${snapshot.error}"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Event> events =
              snapshot.data!.docs.map((e) => Event.fromJson(e)).toList();

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              Event event = events[index];
              return ListTile(
                title: Text(event.title),
                subtitle: Text(event.date.toIso8601String().substring(0, 10)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditEventScreen(event: event)));
                },
              );
            },
          );
        },
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
