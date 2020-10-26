package models

// UserVote represent a vote from a user in the application
type UserVote struct {
	ID     int
	IsYes  bool
	UserID string
	PollID int
}
