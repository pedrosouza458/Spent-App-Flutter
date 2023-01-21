import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewSpent extends StatefulWidget {
  final Function addSt;

  const NewSpent(this.addSt, {super.key});

  @override
  State<NewSpent> createState() => _NewSpentState();
}

class _NewSpentState extends State<NewSpent> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addSt(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  //onChanged: (val) => {titleinput = val},
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _submitData(),
                ),
                Container(
                  height: 40,
                  child: Row(children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}'),
                    ),
                    ElevatedButton(
                        onPressed: _presentDatePicker,
                        child: const Text(
                          'Choose Date',
                        ))
                  ]),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: _submitData,
                    child: const Text('Add Spent'),
                  ),
                )
              ])),
    );
  }
}
