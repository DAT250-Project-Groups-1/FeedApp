package middleware

import (
	"context"
	"net/http"
	"strings"

	"firebase.google.com/go/auth"
	"github.com/gin-gonic/gin"
)

// Auth verifies all authorized operations
func Auth(c *gin.Context) {
	firebase := c.MustGet("auth").(*auth.Client)

	authorization := c.GetHeader("Authorization")
	bearer := strings.TrimSpace(strings.Replace(authorization, "Bearer", "", 1))

	if bearer == "" {
		c.AbortWithStatusJSON(http.StatusBadRequest, gin.H{"error": "token not available"})
		return
	}

	token, err := firebase.VerifyIDToken(context.Background(), bearer)
	if err != nil {
		c.AbortWithStatusJSON(http.StatusBadRequest, gin.H{"error": "invalid token"})
		return
	}

	user, err := firebase.GetUser(context.Background(), token.UID)
	if err != nil {
		c.AbortWithStatusJSON(http.StatusUnauthorized, gin.H{"error": "user not authorized"})
		return
	}

	c.Set("user", user)
	c.Next()
}
