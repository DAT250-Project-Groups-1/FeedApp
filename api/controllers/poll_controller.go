package controllers

import (
	"dat250-project-group-1/feedapp/models"
	"dat250-project-group-1/feedapp/publisher"
	"fmt"
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

	res := db.Where("Code = ?", c.Param("code")).Where("open = ?", "true").Find(&poll)

	if res.Error != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "could not get poll"})
		return
	}

	c.JSON(http.StatusOK, poll)
}

// OpenPoll opens a poll
func OpenPoll(c *gin.Context) {
	db := c.MustGet("db").(*gorm.DB)
	var poll models.Poll

	res := db.Where("id = ?", c.Param("id")).Find(&poll)
	if res.Error != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "could not get poll"})
		return
	}

	poll.Open = true
	http.Post(fmt.Sprintf("https://dweet.io/dweet/for/feedapp-gruppe1?poll=%d&status=open", poll.ID), "text/plain", nil)

	res = db.Save(&poll)

	c.JSON(http.StatusOK, poll)
}

// EndPoll ends a poll and posts to message broker
func EndPoll(c *gin.Context) {
	db := c.MustGet("db").(*gorm.DB)
	var poll models.Poll

	res := db.Where("id = ?", c.Param("id")).Find(&poll)
	if res.Error != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "could not get poll"})
		return
	}

	poll.Open = false
	http.Post(fmt.Sprintf("https://dweet.io/dweet/for/feedapp-gruppe1?poll=%d&status=end", poll.ID), "text/plain", nil)

	res = db.Save(&poll)
	publisher.Publish(poll)

	c.JSON(http.StatusOK, poll)
}

// DeletePoll deletes a poll
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
