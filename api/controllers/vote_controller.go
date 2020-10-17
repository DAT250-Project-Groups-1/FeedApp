package controllers

import (
	"dat250-project-group-1/feedapp/data"
	"dat250-project-group-1/feedapp/models"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

// VoteController handles requests on /votes
type VoteController struct {
	Repo data.VoteRepository
}

// GetVotes gets all votes
var GetVotes = func(p VoteController) func(c *gin.Context) {
	return func(c *gin.Context) {
		votes, err := p.Repo.ReadVotes()
		if err != nil {
			c.JSON(http.StatusNotFound, gin.H{"error": err.Error()})
		} else {
			c.JSON(http.StatusOK, votes)
		}
	}
}

// GetVote gets the vote with specified id
var GetVote = func(p VoteController) func(c *gin.Context) {
	return func(c *gin.Context) {
		id, err := strconv.Atoi(c.Param("id"))
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}

		vote := &models.Vote{ID: id}
		votes, err := p.Repo.ReadVote(vote)
		if err != nil {
			c.JSON(http.StatusNotFound, gin.H{"error": err.Error()})
		} else {
			c.JSON(http.StatusOK, votes)
		}
	}
}

// PostVote inserts a new vote
var PostVote = func(p VoteController) func(c *gin.Context) {
	return func(c *gin.Context) {
		vote := &models.Vote{}
		err := c.Bind(vote)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}
		err = p.Repo.CreateVote(vote)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		} else {
			c.JSON(http.StatusOK, vote)
		}
	}
}

// PutVote updates a vote
var PutVote = func(p VoteController) func(c *gin.Context) {
	return func(c *gin.Context) {
		id, err := strconv.Atoi(c.Param("id"))
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}

		vote := &models.Vote{}
		err = c.Bind(vote)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}

		vote.ID = id

		err = p.Repo.UpdateVote(vote)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		} else {
			c.JSON(http.StatusOK, vote)
		}
	}
}

// DeleteVote deletes a vote
var DeleteVote = func(p VoteController) func(c *gin.Context) {
	return func(c *gin.Context) {
		id, err := strconv.Atoi(c.Param("id"))
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}

		vote := &models.Vote{ID: id}
		err = p.Repo.DeleteVote(vote)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		} else {
			c.JSON(http.StatusOK, vote)
		}
	}
}
