package data

import (
	"dat250-project-group-1/feedapp/models"
)

// UserRepository manage users data
type UserRepository interface {
	ReadUsers() ([]models.User, error)
	ReadUser(*models.User) (*models.User, error)
	CreateUser(*models.User) error
	UpdateUser(*models.User) error
	DeleteUser(*models.User) error
}

// ReadUsers returns all users
func (c *Connection) ReadUsers() ([]models.User, error) {
	var users []models.User
	err := c.Model(&users).Select()
	if err != nil {
		return nil, err
	}
	return users, nil
}

// ReadUser returns user with specified id
func (c *Connection) ReadUser(user *models.User) (*models.User, error) {
	err := c.Model(user).WherePK().Select()
	if err != nil {
		return nil, err
	}
	return user, nil
}

// CreateUser creates a user
func (c *Connection) CreateUser(user *models.User) error {
	_, err := c.Model(user).Insert()
	return err
}

// UpdateUser updates a user
func (c *Connection) UpdateUser(user *models.User) error {
	_, err := c.Model(user).WherePK().Update()
	return err
}

// DeleteUser updates a user
func (c *Connection) DeleteUser(user *models.User) error {
	_, err := c.Model(user).WherePK().Delete()
	return err
}
