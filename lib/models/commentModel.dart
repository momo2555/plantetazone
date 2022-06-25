class CommentModel {
  String? commentId;
  String? commentUserId;
  double? commentRate;
  String? commentText;

  CommentModel() : super();


  set setCommentId(value) {
    commentId = value;
  }
  set setCommentUserId(value) {
    commentUserId = value;
  }
  set setCommentRate(value) {
    commentRate = value;
  }
  set setCommentText(value) {
    commentText = value;
  }


  get getCommentId {
    return commentId;
  }
  get getCommentUserId {
    return commentUserId;
  }
  get getCommentRate {
    return commentRate;
  }
  get getCommentText {
    return commentText;
  }
}