class Vote {
  bool isYes;
  String userID;
  int pollID;

  Vote({this.isYes, this.userID, this.pollID});

  Vote.fromJson(Map<String, dynamic> json) {
    isYes = json['IsYes'];
    userID = json['UserID'];
    pollID = json['PollID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsYes'] = this.isYes.toString();
    data['UserID'] = this.userID.toString();
    data['PollID'] = this.pollID.toString();
    return data;
  }
}