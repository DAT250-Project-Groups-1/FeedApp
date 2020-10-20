package controllers

import (
	"dat250-project-group-1/feedapp/models"
	"net/http"

	"firebase.google.com/go/auth"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

// PostUser add a new user if not already in database, else return the user
func PostUser(c *gin.Context) {
	userRecord := c.MustGet("user").(*auth.UserRecord)
	var user models.User

	db := c.MustGet("db").(*gorm.DB)
	res := db.Preload("Polls").Preload("Votes").Where("id = ?", userRecord.UID).First(&user)
	if res.Error != nil {

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
