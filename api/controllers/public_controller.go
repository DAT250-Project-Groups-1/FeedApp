package controllers

import (
	"dat250-project-group-1/feedapp/models"
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

// GetPublicPolls gets all public polls
func GetPublicPolls(c *gin.Context) {
	db := c.MustGet("db").(*gorm.DB)
	var polls []models.Poll
	res := db.Where("is_private = ?", "false").Where("open = ?", "true").Find(&polls)
	if res.Error != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": res.Error.Error()})
		return
	}

	c.JSON(http.StatusOK, polls)
}

// GetPublicPoll gets public poll from poll code
func GetPublicPoll(c *gin.Context) {
	db := c.MustGet("db").(*gorm.DB)
	var poll models.Poll

	res := db.Where("Code = ?", c.Param("code")).Where("open = ?", "true").Find(&poll)

	if res.Error != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "could not get poll"})
		return
	}

	c.JSON(http.StatusOK, poll)
}

// PostPublicVote adds a public vote to a public poll
func PostPublicVote(c *gin.Context) {
	var vote models.Vote
	err := c.ShouldBind(&vote)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	var poll models.Poll
	db := c.MustGet("db").(*gorm.DB)
	res := db.Where("is_private = ?", "false").Find(&poll, vote.PollID)
	if res.RowsAffected == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": fmt.Sprintf("no poll with id: %d", vote.PollID)})
		return
	}

	if *vote.IsYes {
		poll.CountYes++
	} else {
		poll.CountNo++
	}

	res = db.Save(&poll)
	if res.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": res.Error.Error()})
		return
	}

	c.JSON(http.StatusOK, poll)
}
