import 'package:flutter/material.dart';
import 'package:myapp/models/spent.dart';
import 'package:myapp/widgets/chart.dart';
import 'package:myapp/widgets/new_spent.dart';
import './widgets/spent_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          primaryColor: Colors.purple,
          fontFamily: 'Quicksand'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Spent> _userSpents = [];

  List<Spent> get _recentSpents {
    return _userSpents.where((st) {
      return st.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewSpent(String stTitle, double stAmount, DateTime chosenDate) {
    final newst = Spent(
      title: stTitle,
      amount: stAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userSpents.add(newst);
    });
  }

  void _startAddNewSpent(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewSpent(_addNewSpent),
        );
      },
    );
  }

  void _deleteSpent(String id) {
    setState(() {
      _userSpents.removeWhere((st) {
        return st.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Personal Expenses',
            style: TextStyle(fontFamily: 'Open Sans'),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _startAddNewSpent(context),
            )
          ]),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentSpents),
            SpentList(_userSpents, _deleteSpent)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewSpent(context),
      ),
    );
  }
}
