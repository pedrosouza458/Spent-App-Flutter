import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/spent.dart';

class SpentList extends StatelessWidget {
  final List<Spent> spents;
  final Function deleteSt;

  const SpentList(this.spents, this.deleteSt, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
        child: spents.isEmpty
            ? Column(children: <Widget>[
                const Text('No Spents added yet'),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ])
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 2,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: FittedBox(
                              child: Text(
                                'R\$${spents[index].amount}',
                                style: const TextStyle(fontSize: 20),
                              ),
                            )),
                      ),
                      title: Text(
                        spents[index].title,
                        style: const TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 20,
                        ),
                      ),
                      subtitle:
                          Text(DateFormat.yMMMd().format(spents[index].date)),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteSt(spents[index].id),
                      ),
                    ),
                  );
                },
                itemCount: spents.length,
              ));
  }
}
