import 'package:flutter/material.dart';
import 'package:galaxy_tracker/models.dart';
import 'package:galaxy_tracker/requests.dart';
import 'package:get_storage/get_storage.dart';

class HistoriesPage extends StatefulWidget {
  @override
  _HistoriesPageState createState() => _HistoriesPageState();
}

class _HistoriesPageState extends State<HistoriesPage> {
  String dropdownValue = '0';
  String apiKey;
  List<History> histories;
  @override
  void initState() {
    super.initState();
  }

  Future get_histories() async {
    apiKey = GetStorage().read('token');
    final request = Requests(apiKey);
    histories = await request.get_histories();
    histories.add(History('0', "Histórico"));
    setState(() {});
    return histories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 500,
            minWidth: 100,
            maxHeight: 800,
            // minHeight: 500,
          ),
          child: Column(children: [
            Image(
              image: AssetImage("assets/graphics/dna.png"),
            ),
            FutureBuilder(
              future: get_histories(),
              builder:
                (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return DropdownButton(
                    value: dropdownValue,
                    style: const TextStyle(color: Colors.black),
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value;
                      });
                    },
                    items: histories.map<DropdownMenuItem>((history) {
                      return DropdownMenuItem(
                        value: history.id,
                        child: Text(history.name),
                      );
                    }).toList());
              } else {
                return DropdownButton(
                  value: '0',
                  items: [DropdownMenuItem(value: '0', child: Text('Aguarde'))],
                );
              }
            }),
            // Spacer(flex: 4,),
          ]),
        ),
      ),
    );
  }
}
