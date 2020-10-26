package models

// User represent a user of the application
type User struct {
	ID      string
	Name    string
	Email   string
	IsAdmin bool
	Polls   []Poll
	Votes   []UserVote
}
