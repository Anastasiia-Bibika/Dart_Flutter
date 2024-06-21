import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calendarevents/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class EditEventScreen extends StatefulWidget {
  final Event event;
  EditEventScreen({required this.event});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController starttimeController = TextEditingController(); // Додано поле для starttime
  final TextEditingController endtimeController = TextEditingController(); // Додано поле для endtime

  @override
  void initState() {

    titleController.text = widget.event.title;
    dateController.text = widget.event.date.toIso8601String().substring(0, 10);
    starttimeController.text = widget.event.starttime!;
    endtimeController.text = widget.event.endtime!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Event")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: dateController,
              readOnly: true,
              onTap: () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: widget.event.date,
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2035),
                );
                if (newDate != null) {
                  setState(() {
                    dateController.text = newDate.toIso8601String().substring(0, 10);
                  });
                }
              },
              decoration: InputDecoration(labelText: "Date"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: starttimeController,
              readOnly: true,
              onTap: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (selectedTime != null) {
                  setState(() {
                    starttimeController.text = selectedTime.format(context);
                  });
                }
              },
              decoration: InputDecoration(labelText: "Start Time"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: endtimeController,
              readOnly: true,
              onTap: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (selectedTime != null) {
                  setState(() {
                    endtimeController.text = selectedTime.format(context);
                  });
                }
              },
              decoration: InputDecoration(labelText: "End Time"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Оновити дані події в Firestore
                FirebaseFirestore.instance
                    .collection('events')
                    .doc(widget.event.id)
                    .update({
                  'title': titleController.text,
                  'date': DateTime.parse(dateController.text),
                  'starttime': starttimeController.text,
                  'endtime': endtimeController.text,
                }).then((value) {

                  Navigator.pop(context);
                }).catchError((error) {

                  print("Помилка під час оновлення події: $error");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Помилка під час оновлення події")),
                  );
                });
              },
              child: Text("Save"),
            ),
            ElevatedButton(
              onPressed: () {

                FirebaseFirestore.instance
                    .collection('events')
                    .doc(widget.event.id)
                    .delete()
                    .then((value) {

                  Navigator.pop(context);
                }).catchError((error) {
                  print("Помилка під час видалення події: $error");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Помилка під час видалення події")),
                  );
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF4667)),
              child: Text("Delete"),
            )

          ],
        ),
      ),
    );
  }
}
