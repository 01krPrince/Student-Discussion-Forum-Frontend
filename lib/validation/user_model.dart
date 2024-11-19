class Answer {
  final String id;
  final String userId;
  final String questionId;
  final String answer;
  final int likeCount;
  final List<String> likedByUserIdList;
  final bool isAnswered;

  Answer({
    required this.id,
    required this.userId,
    required this.questionId,
    required this.answer,
    required this.likeCount,
    required this.likedByUserIdList,
    this.isAnswered = false,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      userId: json['userId'],
      questionId: json['questionId'],
      answer: json['answer'],
      likeCount: json['likeCount'],
      likedByUserIdList: List<String>.from(json['likedByUserIdList']),
      isAnswered: json['isAnswered'] ?? false,
    );
  }
}

class Option {
  final String id;
  final String questionId;
  final String optionValue;

  Option({
    required this.id,
    required this.questionId,
    required this.optionValue,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      questionId: json['questionId'],
      optionValue: json['optionValue'],
    );
  }
}

// Question Model
class Question {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String tag;
  final String date;
  final String time;
  final List<Answer> answerList;
  final int noOfOption;
  final List<Option> optionList;
  final int likeCount;
  final List<String> likedByUserId;

  Question({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.tag,
    required this.date,
    required this.time,
    required this.answerList,
    required this.noOfOption,
    required this.optionList,
    required this.likeCount,
    required this.likedByUserId,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      tag: json['tag'],
      date: json['date'],
      time: json['time'],
      answerList: (json['answerList'] as List)
          .map((a) => Answer.fromJson(a))
          .toList(),
      noOfOption: json['noOfOption'],
      optionList: (json['optionList'] as List)
          .map((o) => Option.fromJson(o))
          .toList(),
      likeCount: json['likeCount'],
      likedByUserId: List<String>.from(json['likedByUserId']),
    );
  }
}

// User Model
class User {
  final String userId;
  final String userName;
  final String phone;
  final String password;
  final List<Question> questionList;
  final List<Answer> answeredList;

  User({
    required this.userId,
    required this.userName,
    required this.phone,
    required this.password,
    required this.questionList,
    required this.answeredList,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      userName: json['userName'],
      phone: json['phone'],
      password: json['password'],
      questionList: (json['questionList'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
      answeredList: (json['answeredList'] as List)
          .map((a) => Answer.fromJson(a))
          .toList(),
    );
  }
}
