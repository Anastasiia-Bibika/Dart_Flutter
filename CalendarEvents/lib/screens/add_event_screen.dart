import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  DateTime? _selectedDate;

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
      body: Column(children: [
        TextField(
          controller: titleController,
          decoration: InputDecoration(labelText: "Enter event title"),
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
              initialDate:
                  _selectedDate != null ? _selectedDate! : DateTime.now(),
              firstDate: DateTime(2023),
              lastDate: DateTime(2035),
            );
            if (newDate != null) {
              setState(() {
                _selectedDate = newDate;
                dateController.text =
                    newDate.toIso8601String().substring(0, 10);
              });
            }
          },
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text("Add "),
        )
      ]),
    );
  }
}
