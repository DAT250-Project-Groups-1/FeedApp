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

// GetUserPolls gets all polls a user has made
func GetUserPolls(c *gin.Context) {
	userRecord := c.MustGet("user").(*auth.UserRecord)

	db := c.MustGet("db").(*gorm.DB)
	var polls []models.Poll
	res := db.Where("user_id = ?", userRecord.UID).Find(&polls)
	if res.Error != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": res.Error.Error()})
		return
	}

	c.JSON(http.StatusOK, polls)
}

// Delete a poll
func DeletePoll(c *gin.Context) {

	db := c.MustGet("db").(*gorm.DB)

	var poll models.Poll
	if err := db.Where("id = ?", c.Param("id")).First(&poll).Error; err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Record not found!"})
		return
	}

	db.Delete(&poll)

	c.JSON(http.StatusOK, gin.H{"data": true})
}
