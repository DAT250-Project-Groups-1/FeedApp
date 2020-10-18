package models

// User represent a user of the application
type User struct {
	ID      int
	Name    string
	Email   string
	IsAdmin bool
}
