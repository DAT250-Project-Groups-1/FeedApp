package controllers

import (
	"dat250-project-group-1/feedapp/models"
	"fmt"
	"net/http"

	"firebase.google.com/go/auth"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

// PostVote is posting a user vote
func PostVote(c *gin.Context) {
	var vote models.Vote
	err := c.ShouldBind(&vote)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	var poll models.Poll
	db := c.MustGet("db").(*gorm.DB)
	res := db.Where("is_private = ?", "true").Where("id = ?", vote.PollID).First(&poll)
	if res.Error != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": fmt.Sprintf("no poll with id: %d", vote.PollID)})
		return
	}
	fmt.Println(poll)

	userRecord := c.MustGet("user").(*auth.UserRecord)
	var uv models.UserVote

	res = db.Where("user_id = ?", userRecord.UID).Where("poll_id = ?", poll.ID).First(&uv)
	if res.Error == nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": fmt.Sprintf("user with id: %s already voted on poll with id: %d", userRecord.UID, vote.PollID)})
		return
	}

	uv.IsYes = *vote.IsYes
	uv.PollID = vote.PollID
	uv.UserID = userRecord.UID

	res = db.Create(&uv)
	if res.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": res.Error.Error()})
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
