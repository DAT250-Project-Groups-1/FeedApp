class PublicVote {
  bool isYes;
  int pollID;

  PublicVote({this.isYes, this.pollID});

  PublicVote.fromJson(Map<String, dynamic> json) {
    isYes = json['IsYes'];
    pollID = json['PollID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsYes'] = this.isYes.toString();
    data['PollID'] = this.pollID.toString();
    return data;
  }
}
