import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({Key? key}) : super(key: key);

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  var starttimecontroller = TextEditingController();
  var endtimecontroller = TextEditingController();

  DateTime? _selectedDate;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dateController.text =
        _selectedDate?.toIso8601String().substring(0, 10) ?? "Select Date";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Event")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Enter event title"),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: dateController,
                readOnly: true,
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2035),
                  );
                  if (newDate != null) {
                    setState(() {
                      _selectedDate = newDate;
                      dateController.text = newDate.toIso8601String().substring(0, 10);
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                readOnly: true,
                controller: starttimecontroller,
                decoration: InputDecoration(
                  labelText: "Select Start Time",
                  prefixIcon: Icon(Icons.watch_later_outlined),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Time must not be empty";
                  }
                  return null;
                },
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        starttimecontroller.text = value.format(context).toString();
                      });
                    }
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                readOnly: true,
                controller: endtimecontroller,
                decoration: InputDecoration(
                  labelText: "Select End Time",
                  prefixIcon: Icon(Icons.watch_later_outlined),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Time must not be empty";
                  }
                  return null;
                },
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        endtimecontroller.text = value.format(context).toString();
                      });
                    }
                  });
                },
              ),
              const SizedBox(height: 16),
              //ElevatedButton(
                //onPressed: () {
                  //if (_selectedDate != null) {
                    //FirebaseFirestore.instance.collection('events').add({
                      //'title': titleController.text,
                      //'date': _selectedDate,
                    //});
                    //Navigator.pop(context);
                  //}
                //},
                //child: Text("Add Event"),
              //),
              ElevatedButton.icon(
                onPressed: () async {
                  // Validate the form
                  if (_selectedDate != null && _formKey.currentState!.validate()) {
                    // Parse start and end times
                    DateTime startTime = DateFormat("hh:mm a").parse(starttimecontroller.text);
                    DateTime endTime = DateFormat("hh:mm a").parse(endtimecontroller.text);

                    // Convert start and end times to 24-hour format
                    String startTime24Hour = DateFormat("HH:mm").format(startTime);
                    String endTime24Hour = DateFormat("HH:mm").format(endTime);

                    // Compare start and end times
                    if (startTime.isBefore(endTime)) {
                      // Insert event into Firestore
                      await FirebaseFirestore.instance.collection('events').add({
                        'title': titleController.text,
                        'date': _selectedDate,
                        'starttime': startTime24Hour,
                        'endtime': endTime24Hour,
                      });

                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Event added successfully'),
                      ));

                      // Clear text fields
                      titleController.clear();
                      dateController.clear();
                      starttimecontroller.clear();
                      endtimecontroller.clear();
                      Navigator.pop(context);
                    } else {
                      // Display error message
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('"Start Time" must be before "End Time"'),
                      ));
                    }
                  }
                },
                icon: Icon(Icons.add),
                label: Text("Add Event"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
