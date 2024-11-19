import 'package:flutter/material.dart';
import '../../api/post_answer_api.dart';
import '../../api/response/question.dart';
import '../../validation/validation_api.dart';

class QuestionDetailsPage extends StatefulWidget {
  final Question question;
  const QuestionDetailsPage({Key? key, required this.question}) : super(key: key);

  @override
  _QuestionDetailsPageState createState() => _QuestionDetailsPageState();
}

class _QuestionDetailsPageState extends State<QuestionDetailsPage> {
  bool isQuestionUpvoted = false;
  List<bool> isAnswerUpvoted = [];
  final _answerController = TextEditingController();
  final PostAnswerApi _postAnswerApi = PostAnswerApi();

  late String questionId;

  @override
  void initState() {
    super.initState();

    isAnswerUpvoted = List.generate(widget.question.answerList.length, (index) => false);
  }

  void toggleQuestionUpvote() {
    setState(() {
      if (isQuestionUpvoted) {
        widget.question.likeCount--;
      } else {
        widget.question.likeCount++;
      }
      isQuestionUpvoted = !isQuestionUpvoted;
    });
  }

  void toggleAnswerUpvote(int index) {
    setState(() {
      if (isAnswerUpvoted[index]) {
        widget.question.answerList[index].likeCount--;
      } else {
        widget.question.answerList[index].likeCount++;
      }
      isAnswerUpvoted[index] = !isAnswerUpvoted[index];
    });
  }

  void _submitAnswer() async {
    final String? userId = AuthService.finalUserId;
    String answer = _answerController.text;
    questionId = widget.question.qid;
    if (answer.isNotEmpty) {
      bool isPosted = await _postAnswerApi.postAnswer(questionId, answer);

      if (isPosted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Answer posted successfully!')),
        );
        _answerController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to post the answer.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter an answer.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Question Details',
          style: TextStyle(color: Colors.white70),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(
          color: Colors.white70,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.question.userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${widget.question.date} at ${widget.question.time}',
                    style: TextStyle(
                      color: Colors.grey[850],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "Title: " + widget.question.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.question.description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 10),
              if (widget.question.tag.isNotEmpty)
                Text(
                  'Tag: ${widget.question.tag}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              const SizedBox(height: 10),
              // Options (if available)
              if (widget.question.optionList.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < widget.question.optionList.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          '${String.fromCharCode(65 + i)}.  ${widget.question.optionList[i]}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                  ],
                ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: toggleQuestionUpvote,
                    icon: Icon(
                      isQuestionUpvoted
                          ? Icons.thumb_up
                          : Icons.thumb_up_alt_outlined,
                    ),
                  ),
                  Text(
                    '${widget.question.likeCount}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _answerController,
                decoration: const InputDecoration(
                  labelText: 'Answer here',
                  border: OutlineInputBorder(),
                  hintText: 'Type your answer here...',
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitAnswer,
                child: const Text('Submit Answer'),
              ),
              const SizedBox(height: 20),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              const SizedBox(height: 20),
              if (widget.question.answerList.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < widget.question.answerList.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "~${widget.question.answerList[i].userName}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  '${widget.question.answerList[i].date} at ${widget.question.answerList[i].time}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Text(
                                "Answer : ${widget.question.answerList[i].answer}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isAnswerUpvoted[i]
                                        ? Icons.thumb_up
                                        : Icons.thumb_up_alt_outlined,
                                    color: Colors.grey[400],
                                    size: 12,
                                  ),
                                  onPressed: () => toggleAnswerUpvote(i),
                                ),
                                Text(
                                  '${widget.question.answerList[i].likeCount} Likes',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
