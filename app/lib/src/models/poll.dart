class Poll {
  final int id;
  final String question;
  final bool open;
  final int countYes;
  final int countNo;
  final String code;
  final bool isPrivate;
  final String userId;
  final dynamic votes;
  final dynamic iotVotes;

  Poll.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['ID'],
        question = parsedJson['Question'],
        open = parsedJson['Open'],
        countYes = parsedJson['CountYes'],
        countNo = parsedJson['CountNo'],
        code = parsedJson['Code'],
        isPrivate = parsedJson['IsPrivate'],
        userId = parsedJson['UserID'],
        votes = parsedJson['Votes'],
        iotVotes = parsedJson['IotVotes'];
}
