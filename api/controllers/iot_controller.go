package controllers

import (
	"dat250-project-group-1/feedapp/models"
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

// GetPollForIotDevice gets the poll for the iot device
func GetPollForIotDevice(c *gin.Context) {
	db := c.MustGet("db").(*gorm.DB)
	var poll models.Poll

	res := db.Where("Code = ?", c.Param("code")).Find(&poll)

	if res.Error != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "could not get poll"})
		return
	}

	c.JSON(http.StatusOK, poll)
}

// PostIotDevice add a new iot device with given name if not already in database, else return the iot device with given name
func PostIotDevice(c *gin.Context) {
	var device models.IotDevice

	err := c.ShouldBind(&device)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	db := c.MustGet("db").(*gorm.DB)
	res := db.Where("name = ?", device.Name).First(&device)
	if res.Error != nil {
		res := db.Create(&device)
		if res.Error != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": res.Error.Error()})
			return
		}
		c.JSON(http.StatusOK, device)
	} else {
		c.JSON(http.StatusOK, device)
	}
}

// PostIotVotes posts votes from an iot device
func PostIotVotes(c *gin.Context) {
	var votes models.IotVotes
	err := c.ShouldBind(&votes)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	var poll models.Poll
	db := c.MustGet("db").(*gorm.DB)
	res := db.Find(&poll, votes.PollID)
	if res.RowsAffected == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": fmt.Sprintf("no poll with id: %d", votes.PollID)})
		return
	}

	poll.CountYes += votes.CountYes
	poll.CountNo += votes.CountNo

	res = db.Save(&poll)
	if res.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": res.Error.Error()})
		return
	}

	res = db.Create(&votes)
	if res.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": res.Error.Error()})
		return
	}

	c.JSON(http.StatusOK, votes)
}

//GetIotDevices Gets all iot devices
func GetIotDevices(c *gin.Context) {
	db := c.MustGet("db").(*gorm.DB)
	var iotDevices []models.IotDevice
	res := db.Find(&iotDevices)
	if res.Error != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": res.Error.Error()})
		return
	}

	c.JSON(http.StatusOK, iotDevices)
}
