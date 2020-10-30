class Poll {
  int id;
  String question;
  bool open;
  int countYes;
  int countNo;
  String code;
  bool isPrivate;
  String userId;
  dynamic votes;
  dynamic iotVotes;

  Poll({this.question, this.open, this.countYes, this.countNo, this
      .code, this.isPrivate, this.userId, this.votes, this.iotVotes});

  Poll.fromJson(Map<String, dynamic> parsedJson){
    id = parsedJson['ID'];
    question = parsedJson['Question'];
    open = parsedJson['Open'];
    countYes = parsedJson['CountYes'];
    countNo = parsedJson['CountNo'];
    code = parsedJson['Code'];
    isPrivate = parsedJson['IsPrivate'];
    userId = parsedJson['UserID'];
    votes = parsedJson['Votes'];
    iotVotes = parsedJson['IotVotes'];
  }

  Map toJson() => {'ID': id, 'Question': question, 'Open': open, 'CountYes':
  countYes,  'CountNo': countNo, 'Code': code, 'IsPrivate': isPrivate, 'UserI'
      'd': userId, 'Votes': votes, 'IotVotes': iotVotes};


}
