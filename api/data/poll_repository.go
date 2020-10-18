package data

import (
	"dat250-project-group-1/feedapp/models"
)

// PollRepository manage polls data
type PollRepository interface {
	ReadPolls() ([]models.Poll, error)
	ReadPoll(*models.Poll) (*models.Poll, error)
	CreatePoll(*models.Poll) error
	UpdatePoll(*models.Poll) error
	DeletePoll(*models.Poll) error
}

// ReadPolls returns all polls
func (c *Connection) ReadPolls() ([]models.Poll, error) {
	var Polls []models.Poll
	err := c.Model(&Polls).Select()
	if err != nil {
		return nil, err
	}
	return Polls, nil
}

// ReadPoll returns poll with specified id
func (c *Connection) ReadPoll(poll *models.Poll) (*models.Poll, error) {
	err := c.Model(poll).WherePK().Select()
	if err != nil {
		return nil, err
	}
	return poll, nil
}

// CreatePoll creates a poll
func (c *Connection) CreatePoll(poll *models.Poll) error {
	_, err := c.Model(poll).Insert()
	return err
}

// UpdatePoll updates a poll
func (c *Connection) UpdatePoll(poll *models.Poll) error {
	_, err := c.Model(poll).WherePK().Update()
	return err
}

// DeletePoll updates a poll
func (c *Connection) DeletePoll(poll *models.Poll) error {
	_, err := c.Model(poll).WherePK().Delete()
	return err
}
