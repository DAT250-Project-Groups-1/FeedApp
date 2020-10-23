package controllers

import (
	"dat250-project-group-1/feedapp/models"
	"net/http"

	"firebase.google.com/go/auth"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

// GetUsers gets all users
func GetUsers(c *gin.Context) {
	userRecord := c.MustGet("user").(*auth.UserRecord)
	var user models.User

	db := c.MustGet("db").(*gorm.DB)
	res := db.Find(&user, userRecord.UID)

	if !user.IsAdmin {
		//c.JSON(http.StatusUnauthorized, gin.H{"error": "user not authorized"})
		//return
	}

	var users []models.User
	res = db.Find(&users)
	if res.Error != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "no users"})
		return
	}

	c.JSON(http.StatusOK, users)
}
// EditUser edits one user
func EditUser(c *gin.Context) {
	userRecord := c.MustGet("user").(*auth.UserRecord)
	var user models.User

	db := c.MustGet("db").(*gorm.DB)
	res := db.Find(&user, userRecord.UID)

	if !user.IsAdmin {
		//c.JSON(http.StatusUnauthorized, gin.H{"error": "user not authorized"})
		//return
	}

	var userToEdit models.User
	res = db.Find(&userToEdit, c.Param("uid"))

	if res.Error != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "no user with given uid"})
		return
	}

	userToEdit.IsAdmin = true
	res = db.Update(c.Param("uid"), userToEdit)

	if res.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error" : "count not edit user"})
		return
	}

	c.JSON(http.StatusOK, userToEdit)
}
