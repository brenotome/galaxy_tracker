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
  List<HistoryItem> items = [];

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
  Future update_items(id) async{
    final request = Requests(apiKey);
    if(id != '0'){
      items = await request.get_history_items(id);
    }
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
            SizedBox(height: 30),
            Container(
                width: 100,
                height: 100,
                child: Image(
                  image: AssetImage("assets/graphics/dna.png"),
                )),
            FutureBuilder(
                future: get_histories(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return DropdownButton(
                        value: dropdownValue,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (value) {
                          update_items(value);
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
                      items: [
                        DropdownMenuItem(value: '0', child: Text('Aguarde'))
                      ],
                    );
                  }
                }),
            SizedBox(height: 15),
            RichText(
              text: TextSpan(
                text: "Minhas Tarefas",
                style: TextStyle(
                    fontFamily: "Roboto",
                    color: Color(0xFF3A6175),
                    fontSize: 48),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: ListView(
                children: items.map<Widget>((item) {
                  Color stateColor;
                  if (item.state == 'ok') {
                    stateColor = Color(0xFFD5EDAB);
                  } else if (item.state == 'failed') {
                    stateColor = Color(0xFFFF9B9B);
                  } else if (item.state == 'pprocessing') {
                    stateColor = Color(0xFFFFD564);
                  } else {
                    stateColor = Color(0xFFCBD7DD);
                  }
                  return Container(
                      color: stateColor,
                      child: ListTile(
                        title: Text(item.name),
                      ));
                }).toList(),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
