package controllers

import (
	"dat250-project-group-1/feedapp/models"
	"fmt"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
	"net/http"
)

func PostVote(c *gin.Context) {
	var vote models.Vote
	err := c.ShouldBind(&vote)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	var poll models.Poll
	db := c.MustGet("db").(*gorm.DB)
	res := db.Where("is_private = ?", "true").Find(&poll, vote.PollID)
	if res.RowsAffected == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": fmt.Sprintf("no poll with id: %d", vote.PollID)})
		return
	}

	res = db.Create(&vote)
	if res.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": res.Error.Error()})
		return
	}

	if vote.IsYes {
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
