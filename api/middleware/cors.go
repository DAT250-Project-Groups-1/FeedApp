package middleware

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

// Cors is allowing cors
func Cors(c *gin.Context) {
	c.Header("Access-Control-Allow-Origin", "*")
	c.Header("Access-Control-Allow-Methods", "GET,POST,PUT,PATCH,DELETE,OPTIONS")
	c.Header("Access-Control-Allow-Headers", "authorization, origin, content-type, accept")
	c.Header("Allow", "HEAD,GET,POST,PUT,PATCH,DELETE,OPTIONS")
	c.Header("Content-Type", "application/json")
	if c.Request.Method == "OPTIONS" {
		c.AbortWithStatus(http.StatusOK)
	} else {
		c.Next()
	}
}
