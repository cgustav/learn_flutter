import 'package:learn_redux/models/owner.model.dart';

///Clase Modelo contenedor para
///publicaciones provenientes desde
///la API de StackOverflow.
///
///Incluye recepción del payload básico
///desde su constructor factory.

class StackOverflowModel {
  List<String> tags;
  Owner owner;
  bool isAnswered;
  int viewCount;
  int closedDate;
  int answerCount;
  int score;
  int lastActivityDate;
  int creationDate;
  int lastEditDate;
  int questionId;
  String link;
  String closedReason;
  String title;

  StackOverflowModel({
    this.tags,
    this.owner,
    this.isAnswered,
    this.viewCount,
    this.closedDate,
    this.answerCount,
    this.score,
    this.lastActivityDate,
    this.creationDate,
    this.lastEditDate,
    this.questionId,
    this.link,
    this.closedReason,
    this.title,
  });

  factory StackOverflowModel.fromJson(Map<String, dynamic> json) {
    return new StackOverflowModel(
        tags: json['tags'].cast<String>(),
        owner: json['owner'] ?? Owner.fromJson(json['owner']) ?? null,
        isAnswered: json['is_answered'],
        viewCount: json['view_count'],
        answerCount: json['answer_count'],
        score: json['score'],
        lastActivityDate: json['last_activity_date'],
        creationDate: json['creation_date'],
        questionId: json['question_id'],
        link: json['link'],
        title: json['title']);
  }

  Map<String, dynamic> get toJson => {
        'tags': this.tags,
        'owner': this.owner.toJson(),
        'is_answered': this.isAnswered,
        'view_count': this.viewCount,
        'answer_count': this.answerCount,
        'score': this.score,
        'last_activity_date': this.lastActivityDate,
        'creation_date': this.creationDate,
        'last_edit_date': this.lastEditDate,
        'question_id': this.questionId,
        'link': this.link,
        'title': this.title,
      };

  @override
  String toString() => this.toJson.toString();
}
