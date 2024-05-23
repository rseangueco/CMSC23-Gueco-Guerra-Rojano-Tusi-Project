import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {
  final Map<dynamic, dynamic> dateTime;
  const DateTimePicker({super.key, required this.dateTime});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Padding(
          padding: EdgeInsets.all(10),
          child: Text("Choose date and time for pickup/drop-off")),

      FormField(
        builder: (FormFieldState<bool> state){
          return ElevatedButton(
        onPressed: () => _datePicker(context),
        child: const Text('Pick a date'),
      );
        },
        onSaved: (_) {
          widget.dateTime['date'] = selectedDate;
        }
      ),
      
      FormField(
        builder: (FormFieldState<bool> state){
          return ElevatedButton(
        onPressed: () => _timePicker(context),
        child: const Text('Pick a time'),
      );
        },
        onSaved: (_) {
          widget.dateTime['time'] = selectedTime;
        }
      ),
      Visibility(
        visible: (selectedDate == null || selectedTime == null ? false : true),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child:(selectedDate == null || selectedTime == null ? 
          const Text("")
          :
          Text("Chosen date and time: ${DateFormat.yMMMMd('en_US').format(selectedDate!)} at ${selectedTime!.format(context)}"))
          )),
    ]);
  }

  Future<void> _datePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(2100));
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _timePicker(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

}
