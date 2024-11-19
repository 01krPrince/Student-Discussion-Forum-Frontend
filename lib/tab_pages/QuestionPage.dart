import 'package:flutter/material.dart';
import '../api/new_question_api.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagController = TextEditingController();
  final _optionsController = TextEditingController();

  final NewQuestionApi _api = NewQuestionApi();
  List<Map<String, dynamic>> _questions = [];

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false; // Add a loading state

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  // Fetch questions with loading indicator
  void _fetchQuestions() async {
    setState(() {
      _isLoading = true; // Set loading to true when fetching
    });

    var questions = await _api.fetchMyQuestions();

    setState(() {
      _questions = questions;
      _isLoading = false; // Set loading to false after fetching
    });
  }

  // Post new question with loading indicator
  void _postNewQuestion() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true; // Set loading to true when posting
      });

      final title = _titleController.text;
      final description = _descriptionController.text;
      final tag = _tagController.text;
      final options = _optionsController.text;

      bool isPosted = await _api.postNewQuestion(title, description, tag, options);

      setState(() {
        _isLoading = false; // Set loading to false after posting
      });

      if (isPosted) {
        _fetchQuestions(); // Refresh the list of questions
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Question posted successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to post the question.')),
        );
      }
    }
  }

  // Refresh callback for pull-to-refresh
  Future<void> _refreshQuestions() async {
    _fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('My Questions', style: TextStyle(color: Colors.white70)),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshQuestions, // Pull-to-refresh callback
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Title
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Title is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),

                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null, // Allow the description to be multiline
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Description is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),

                      TextField(
                        controller: _tagController,
                        decoration: const InputDecoration(
                          labelText: 'Tag',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),

                      TextField(
                        controller: _optionsController,
                        decoration: const InputDecoration(
                          labelText: 'Options (comma-separated)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _postNewQuestion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                        child: const Text('Post Question', style: TextStyle(color: Colors.white70)),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                const SizedBox(height: 20),

                // Show a loading indicator while data is being fetched
                if (_isLoading)
                  Center(child: CircularProgressIndicator()),
                // If not loading, show the list of questions
                if (!_isLoading)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _questions.length,
                    itemBuilder: (context, index) {
                      final question = _questions[index];
                      return Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      question['title'] ?? 'No title',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        question['date'] ?? 'N/A',
                                        style: TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                      Text(
                                        question['time'] ?? 'N/A',
                                        style: TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(question['description'] ?? 'No description'),
                              const SizedBox(height: 8),
                              Text('Upvotes: ${question['upvoteCount'] ?? 0}'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
