package controllers

import (
	"dat250-project-group-1/feedapp/models"
	"net/http"

	"firebase.google.com/go/auth"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

// PostPoll creates a new poll with the creators id as user id
func PostPoll(c *gin.Context) {
	userRecord := c.MustGet("user").(*auth.UserRecord)

	var poll models.Poll
	err := c.ShouldBind(&poll)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	poll.UserID = userRecord.UID

	db := c.MustGet("db").(*gorm.DB)
	res := db.Create(&poll)
	if res.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": res.Error.Error()})
		return
	}

	c.JSON(http.StatusOK, poll)
}
