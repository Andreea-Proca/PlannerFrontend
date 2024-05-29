import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planner_frontend/services/models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to create a full topic with quizzes and questions
  Future<void> createFullTopic(Topic topic) async {
    var option1 = Option(value: "Option 1", detail: "Detail 1", correct: true);
    var option2 = Option(value: "Option 2", detail: "Detail 2", correct: false);
    var question =
        Question(options: [option1, option2], text: "What is 2 + 2?");
    var quiz = Quiz(id: "quiz1", title: "Basic Math", questions: [question]);
    var topic = Topic(id: "topic5", title: "Mathematics", quizzes: [quiz]);

    // Create a reference to the 'topics' collection
    var topicRef = _db.collection('topics').doc(topic.id);

    // Add the topic to Firestore
    await topicRef.set(topic.toJson());

    // Loop through each quiz in the topic
    for (var quiz in topic.quizzes) {
      // Create a reference to the subcollection 'quizzes' under the current topic
      var quizRef = topicRef.collection('quizzes').doc(quiz.id);

      // Add the quiz to Firestore
      await quizRef.set(quiz.toJson());

      // Loop through each question in the quiz
      for (var question in quiz.questions) {
        // Create a reference to the subcollection 'questions' under the current quiz
        var questionRef = quizRef
            .collection('questions')
            .doc(); // Generate a new document ID for the question

        // Add the question to Firestore
        await questionRef.set(question.toJson());
      }
    }
  }
}





// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:planner_frontend/services/models.dart';

// void addTopicToFirestore() async {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   Topic newTopic = Topic(
//     id: '1',
//     title: 'New Topic',
//     description: 'This is a new topic',
//     img: 'new_topic.png',
//     quizzes: [],
//   );

//   await firestore.collection('topics').add(newTopic.toJson());
// }

// void addQuizToFirestore() async {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   Quiz newQuiz = Quiz(
//     id: '1',
//     title: 'New Quiz',
//     description: 'This is a new quiz',
//     video: 'new_quiz.mp4',
//     topic: '1',
//     questions: [],
//   );

//   await firestore.collection('quizzes').add(newQuiz.toJson());
// }

// void addTopicWithQuizzesToFirestore() async {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   // Define some options
//   List<Option> options = [
//     Option(value: 'Option 1', detail: 'Detail 1', correct: true),
//     Option(value: 'Option 2', detail: 'Detail 2', correct: false),
//   ];

//   // Convert each Option object to a Map
//   List<Map<String, dynamic>> optionsJson =
//       options.map((option) => option.toJson()).toList();

//   // Define some questions with options
//   List<Question> questions = [
//     Question(
//       text: 'Question 1',
//       options: optionsJson.map((json) => Option.fromJson(json)).toList(),
//     ),
//     Question(
//       text: 'Question 2',
//       options: optionsJson.map((json) => Option.fromJson(json)).toList(),
//     ),
//   ];

//   // Convert each Question object to a Map
//   List<Map<String, dynamic>> questionsJson =
//       questions.map((question) => question.toJson()).toList();

//   // Define some quizzes with questions
//   List<Quiz> quizzes = [
//     Quiz(
//       id: '1',
//       title: 'Quiz 1',
//       description: 'This is quiz 1',
//       video: 'quiz1.mp4',
//       topic: '1',
//       questions: questionsJson.map((json) => Question.fromJson(json)).toList(),
//     ),
//     Quiz(
//       id: '2',
//       title: 'Quiz 2',
//       description: 'This is quiz 2',
//       video: 'quiz2.mp4',
//       topic: '1',
//       questions: questionsJson.map((json) => Question.fromJson(json)).toList(),
//     ),
//   ];

//   // Convert each Quiz object to a Map
//   List<Map<String, dynamic>> quizzesJson =
//       quizzes.map((quiz) => quiz.toJson()).toList();

//   Topic newTopic = Topic(
//     id: '1',
//     title: 'New Topic',
//     description: 'This is a new topic',
//     img: 'new_topic.png',
//     quizzes: quizzesJson
//         .map((json) => Quiz.fromJson(json))
//         .toList(), // Convert the list of maps to a list of Quiz objects
//   );

//   await firestore.collection('topics').add(newTopic.toJson());
// }

// void addReportToFirestore() async {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   Report newReport = Report(
//     uid: '1',
//     total: 0,
//     topics: {},
//   );

//   await firestore.collection('reports').add(newReport.toJson());
// }
