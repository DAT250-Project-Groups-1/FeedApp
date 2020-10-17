package data

import (
	"dat250-project-group-1/feedapp/models"
)

// VoteRepository manage votes data
type VoteRepository interface {
	ReadVotes() ([]models.Vote, error)
	ReadVote(*models.Vote) (*models.Vote, error)
	CreateVote(*models.Vote) error
	UpdateVote(*models.Vote) error
	DeleteVote(*models.Vote) error
}

// ReadVotes returns all votes
func (c *Connection) ReadVotes() ([]models.Vote, error) {
	var votes []models.Vote
	err := c.Model(&votes).Select()
	if err != nil {
		return nil, err
	}
	return votes, nil
}

// ReadVote returns vote with specified id
func (c *Connection) ReadVote(vote *models.Vote) (*models.Vote, error) {
	err := c.Model(vote).WherePK().Select()
	if err != nil {
		return nil, err
	}
	return vote, nil
}

// CreateVote creates a vote
func (c *Connection) CreateVote(vote *models.Vote) error {
	_, err := c.Model(vote).Insert()
	return err
}

// UpdateVote updates a vote
func (c *Connection) UpdateVote(vote *models.Vote) error {
	_, err := c.Model(vote).WherePK().Update()
	return err
}

// DeleteVote updates a vote
func (c *Connection) DeleteVote(vote *models.Vote) error {
	_, err := c.Model(vote).WherePK().Delete()
	return err
}
