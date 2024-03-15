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

  @override
  void initState() {
    titleController.text = widget.event.title;
    dateController.text = widget.event.date.toIso8601String().substring(0, 10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Event")),
      body: Column(children: [
        TextField(
          controller: titleController,
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          controller: dateController,
          readOnly: true,
          onTap: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: widget.event.date,
                firstDate: DateTime(2023),
                lastDate: DateTime(2035));
            if (newDate != null) {
              setState(() {
                dateController.text =
                    newDate.toIso8601String().substring(0, 10);
              });
            }
          },
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection('events')
                .doc(widget.event.id)
                .update({
              'titile': titleController.text,
              'date': DateTime.parse(dateController.text)
            });
            Navigator.pop(context);
          },
          child: Text("Save"),
        ),
        ElevatedButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection('events')
                .doc(widget.event.id)
                .delete();
            Navigator.pop(context);
          },
          child: Text("Delete"),
        )
      ]),
    );
  }
}
