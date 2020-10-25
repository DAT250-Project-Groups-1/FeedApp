package main

import (
	"dat250-project-group-1/feedapp/config"
	"dat250-project-group-1/feedapp/controllers"
	"dat250-project-group-1/feedapp/middleware"

	"github.com/gin-gonic/gin"
)

func main() {

	// Initialize database connection
	db := config.InitDatabase()

	// Initialize firebase auth
	auth := config.InitFirebase()

	// Initialize a gin router engine
	router := gin.Default()

	// Registrer middlewares
	router.Use(func(c *gin.Context) {
		c.Set("db", db)
		c.Set("auth", auth)
	})

	router.Use(middleware.Cors)

	// Registrer routes
	admin := router.Group("/admin")
	admin.Use(middleware.Auth)
	{
		admin.GET("/users", controllers.GetUsers)
		admin.PUT("/makeAdmin/:uid", controllers.MakeAdmin)
	}

	users := router.Group("/users")
	users.Use(middleware.Auth)
	{
		users.POST("", controllers.PostUser)
	}

	polls := router.Group("/polls")
	polls.Use(middleware.Auth)
	{
		polls.POST("", controllers.PostPoll)
		polls.GET("/:code", controllers.GetPoll)
	}

	votes := router.Group("/votes")
	votes.Use(middleware.Auth)
	{
		votes.POST("", controllers.PostVote)
	}


	public := router.Group("/public")
	{
		public.GET("/polls", controllers.GetPublicPolls)
		public.POST("/vote", controllers.PostPublicVote)
	}

	// Start the server on port 8080
	router.Run()
}
