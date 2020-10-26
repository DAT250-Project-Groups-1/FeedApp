class Vote {
  bool isYes;
  int pollID;

  Vote({this.isYes, this.pollID});

  Vote.fromJson(Map<String, dynamic> json) {
    isYes = json['IsYes'];
    pollID = json['PollID'];
  }

  Map toJson() => {'IsYes': isYes, 'PollID': pollID};
}
