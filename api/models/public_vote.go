package models

// PublicVote represents a vote without login needed
type PublicVote struct {
	IsYes  bool `binding:"required"`
	PollID int  `binding:"required"`
}
