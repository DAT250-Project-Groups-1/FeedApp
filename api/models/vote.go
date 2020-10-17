package models

// Vote represent a vote from a user in the application
type Vote struct {
	ID     int
	IsYes  bool
	UserID int
	PollID int
}
