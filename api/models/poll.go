package models

// Poll represent a poll created by an user in the application
type Poll struct {
	ID        int
	Question  string
	Open      bool
	CountYes  int
	CountNo   int
	Code      string
	IsPrivate bool
	UserID    string
	Votes     []UserVote
	IotVotes  []IotVotes
}
