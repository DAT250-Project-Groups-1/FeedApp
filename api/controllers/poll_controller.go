package controllers

import (
	"dat250-project-group-1/feedapp/data"
	"dat250-project-group-1/feedapp/models"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

// PollController handles requests on /polls
type PollController struct {
	Repo data.PollRepository
}

// GetPolls gets all polls
var GetPolls = func(p PollController) func(c *gin.Context) {
	return func(c *gin.Context) {
		polls, err := p.Repo.ReadPolls()
		if err != nil {
			c.JSON(http.StatusNotFound, gin.H{"error": err.Error()})
		} else {
			c.JSON(http.StatusOK, polls)
		}
	}
}

// GetPoll gets the poll with specified id
var GetPoll = func(p PollController) func(c *gin.Context) {
	return func(c *gin.Context) {
		id, err := strconv.Atoi(c.Param("id"))
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}

		poll := &models.Poll{ID: id}
		polls, err := p.Repo.ReadPoll(poll)
		if err != nil {
			c.JSON(http.StatusNotFound, gin.H{"error": err.Error()})
		} else {
			c.JSON(http.StatusOK, polls)
		}
	}
}

// PostPoll inserts a new poll
var PostPoll = func(p PollController) func(c *gin.Context) {
	return func(c *gin.Context) {
		poll := &models.Poll{}
		err := c.Bind(poll)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}
		err = p.Repo.CreatePoll(poll)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		} else {
			c.JSON(http.StatusOK, poll)
		}
	}
}

// PutPoll updates a poll
var PutPoll = func(p PollController) func(c *gin.Context) {
	return func(c *gin.Context) {
		id, err := strconv.Atoi(c.Param("id"))
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}

		poll := &models.Poll{}
		err = c.Bind(poll)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}

		poll.ID = id

		err = p.Repo.UpdatePoll(poll)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		} else {
			c.JSON(http.StatusOK, poll)
		}
	}
}

// DeletePoll deletes a poll
var DeletePoll = func(p PollController) func(c *gin.Context) {
	return func(c *gin.Context) {
		id, err := strconv.Atoi(c.Param("id"))
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}

		poll := &models.Poll{ID: id}
		err = p.Repo.DeletePoll(poll)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		} else {
			c.JSON(http.StatusOK, poll)
		}
	}
}
