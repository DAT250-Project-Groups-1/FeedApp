package models

// Vote represents a vote without login needed
type Vote struct {
	IsYes  *bool `json:"IsYes" binding:"required"`
	PollID int   `json:"PollID" binding:"required"`
}
