package controllers

import (
	"dat250-project-group-1/feedapp/data"
	"dat250-project-group-1/feedapp/models"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

// UserController handles requests on /users
type UserController struct {
	Repo data.UserRepository
}

// GetUsers gets all users
var GetUsers = func(u UserController) func(c *gin.Context) {
	return func(c *gin.Context) {
		users, err := u.Repo.ReadUsers()
		if err != nil {
			c.JSON(http.StatusNotFound, gin.H{"error": err.Error()})
		} else {
			c.JSON(http.StatusOK, users)
		}
	}
}

// GetUser gets the user with specified id
var GetUser = func(u UserController) func(c *gin.Context) {
	return func(c *gin.Context) {
		id, err := strconv.Atoi(c.Param("id"))
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}

		user := &models.User{ID: id}
		user, err = u.Repo.ReadUser(user)
		if err != nil {
			c.JSON(http.StatusNotFound, gin.H{"error": err.Error()})
		} else {
			c.JSON(http.StatusOK, user)
		}
	}
}

// PostUser inserts a new user
var PostUser = func(u UserController) func(c *gin.Context) {
	return func(c *gin.Context) {
		user := &models.User{}
		err := c.Bind(user)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}

		err = u.Repo.CreateUser(user)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		} else {
			c.JSON(http.StatusOK, user)
		}
	}
}

// PutUser updates a user
var PutUser = func(u UserController) func(c *gin.Context) {
	return func(c *gin.Context) {
		id, err := strconv.Atoi(c.Param("id"))
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}

		user := &models.User{}
		err = c.Bind(user)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}

		user.ID = id

		err = u.Repo.UpdateUser(user)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		} else {
			c.JSON(http.StatusOK, user)
		}
	}
}

// DeleteUser deletes a user
var DeleteUser = func(u UserController) func(c *gin.Context) {
	return func(c *gin.Context) {
		id, err := strconv.Atoi(c.Param("id"))
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}

		user := &models.User{ID: id}
		err = u.Repo.DeleteUser(user)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		} else {
			c.JSON(http.StatusOK, user)
		}
	}
}
