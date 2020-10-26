package controllers

import (
	"context"
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
	res := db.First(&user, "ID = ?", userRecord.UID)

	if !user.IsAdmin {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "user not authorized"})
		return
	}

	var users []models.User
	res = db.Find(&users)
	if res.Error != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "no users"})
		return
	}

	c.JSON(http.StatusOK, users)
}

// MakeAdmin makes user admin
func MakeAdmin(c *gin.Context) {
	userRecord := c.MustGet("user").(*auth.UserRecord)
	var user models.User

	db := c.MustGet("db").(*gorm.DB)
	res := db.First(&user, "ID = ?", userRecord.UID)

	if !user.IsAdmin {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "user not authorized"})
		return
	}

	var userToEdit models.User
	res = db.Model(&userToEdit).Where("ID = ?", c.Param("uid")).Update("IsAdmin", true)

	if res.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "count not edit user"})
		return
	}

	auth := c.MustGet("auth").(*auth.Client)

	claims := map[string]interface{}{"admin": true}
	err := auth.SetCustomUserClaims(context.Background(), userRecord.UID, claims)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "error setting custom claim"})
		return
	}

	c.JSON(http.StatusOK, userToEdit)
}
