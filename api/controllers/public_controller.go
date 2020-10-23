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
	res := db.Where("is_private = ?", "false").Find(&polls)
	if res.Error != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": res.Error.Error()})
		return
	}

	c.JSON(http.StatusOK, polls)
}

// PostPublicVote adds a public vote to a public poll
func PostPublicVote(c *gin.Context) {
	var pv models.PublicVote
	err := c.ShouldBind(&pv)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	var poll models.Poll
	db := c.MustGet("db").(*gorm.DB)
	res := db.Where("is_private = ?", "false").Find(&poll, pv.PollID)
	if res.RowsAffected == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": fmt.Sprintf("no poll with id: %d", pv.PollID)})
		return
	}

	if pv.IsYes {
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

// GetPoll gets poll from poll code
func GetPoll(c *gin.Context) {
	db := c.MustGet("db").(*gorm.DB)
	var poll models.Poll

	res := db.Where("Code = ?", c.Param("code")).Where("is_private = ?", "true").Find(&poll)

	if res.Error != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "could not get poll"})
		return
	}

	c.JSON(http.StatusOK, poll)
}
