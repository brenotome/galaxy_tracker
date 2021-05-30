class HistoryItem {
  String id;
  String name;
  String state;

  HistoryItem(id, name, state) {
    this.id = id;
    this.name = name;
    this.state = state;
  }

  HistoryItem.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      state = json['state'];
}

class History {
  String id;
  String name;

  History(id, name) {
    this.id = id;
    this.name = name;
  }

  History.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}
