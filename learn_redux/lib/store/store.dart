import 'package:flutter/foundation.dart';

class LoadQuestionAction {}

class StackOverflowModel {}

class LoadQuestionSuccessAction {
  final List<StackOverflowModel> questions;

  LoadQuestionSuccessAction({@required this.questions});
}
