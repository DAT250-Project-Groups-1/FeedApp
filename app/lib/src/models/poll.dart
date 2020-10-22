class Poll {
  final int id;
  final String question;
  final int countYes;
  final int countNo;
  final DateTime fromDate;
  final DateTime toDate;
  final String code;
  final String userId;
  final bool isPrivate;
  final dynamic votes;
  final dynamic iotVotes;

  Poll.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['ID'],
        question = parsedJson['Question'],
        fromDate = DateTime.parse(parsedJson['FromDate']),
        toDate = DateTime.parse(parsedJson['ToDate']),
        countYes = parsedJson['CountYes'],
        countNo = parsedJson['CountNo'],
        code = parsedJson['Code'],
        isPrivate = parsedJson['IsPrivate'],
        userId = parsedJson['UserID'],
        votes = parsedJson['Votes'],
        iotVotes = parsedJson['IotVotes'];
}
