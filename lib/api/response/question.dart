class Question {
  final String qid;
  final String userName;
  final String title;
  final String description;
  final String date;
  final String time;
  late final int likeCount;
  final String tag;
  final List<String> optionList;
  final List<Answer> answerList;

  Question({
    required this.qid,
    required this.userName,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.likeCount,
    required this.tag,
    required this.optionList,
    required this.answerList,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    var answerListJson = json['answerList'] as List;
    List<Answer> answers = answerListJson.map((e) => Answer.fromJson(e)).toList();

    var optionsJson = json['optionList'] as List;
    List<String> options = optionsJson.map((e) => e.toString()).toList();

    return Question(
      qid: json['id'],
      userName: json['userName'] ?? 'Unknown User',
      title: json['title'] ?? 'Untitled',
      description: json['description'] ?? 'No description available',
      date: json['date'] ?? 'Unknown Date',
      time: json['time'] ?? 'Unknown Time',
      likeCount: json['likeCount'] ?? 0,
      tag: json['tag'] ?? 'No Tag',
      optionList: options,
      answerList: answers,
    );
  }
}

class Answer {
  final String answer;
  final String userName;
  late final int likeCount;
  final String date;
  final String time;

  Answer({
    required this.answer,
    required this.userName,
    required this.likeCount,
    required this.date,
    required this.time,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      answer: json['answer'] ?? 'Not Answered',
      userName: json['userName'] ?? 'User',
      likeCount: json['likeCount'] ?? 0,
      date: json['date'] ?? 'date',
      time: json['time'] ?? 'time',
    );
  }
}
