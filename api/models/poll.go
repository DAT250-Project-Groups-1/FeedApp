package models

// Poll represent a poll created by an user in the application
type Poll struct {
	ID        int
	Question  string
	FromDate  string
	ToDate    string
	CountYes  int
	CountNo   int
	Code      string
	IsPrivate bool
	UserID    int
}
