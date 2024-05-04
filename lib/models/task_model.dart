class Task {
  String id;
  final String title;
  final String description;
  final DateTime date;
  final bool isDone;

  Task({
    this.id = '',
    required this.title,
    required this.description,
    required this.date,
    this.isDone = false,
  });

  factory Task.fromJson(jsonData) {
    return Task(
      id: jsonData['id'] as String,
      title: jsonData['title'] as String,
      description: jsonData['description'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(jsonData[
          'date']), // we will store it in firebase as int and recieve it as DateTime
      isDone: jsonData['isDone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'isDone': isDone
    };
  }
}



  // fromJson   Map => object
  // toJsom     object => Map 
