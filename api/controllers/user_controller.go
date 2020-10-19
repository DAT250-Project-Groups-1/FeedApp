package controllers

import (
	"dat250-project-group-1/feedapp/models"
	"net/http"

	"firebase.google.com/go/auth"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

// GetUser gets the authenticated user
func GetUser(c *gin.Context) {
	userRecord := c.MustGet("user").(*auth.UserRecord)
	var user models.User

	db := c.MustGet("db").(*gorm.DB)
	res := db.Preload("Polls").Preload("Votes").Find(&user, userRecord.UID)

	if res.Error != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": res.Error.Error()})
	} else {
		c.JSON(http.StatusOK, user)
	}
}

// PostUser add a new user if not already in database, else return the user
func PostUser(c *gin.Context) {
	userRecord := c.MustGet("user").(*auth.UserRecord)
	var user models.User

	db := c.MustGet("db").(*gorm.DB)
	res := db.Find(&user, userRecord.UID)

	if res.RowsAffected == 0 {

		user.ID = userRecord.UID
		user.Name = userRecord.DisplayName
		user.Email = userRecord.Email

		res = db.Create(&user)
		if res.Error != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": res.Error.Error()})
			return
		}

		c.JSON(http.StatusOK, user)
	} else {
		c.JSON(http.StatusOK, user)
	}
}
