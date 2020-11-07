package main

import (
	"dat250-project-group-1/feedapp/config"
	"dat250-project-group-1/feedapp/controllers"
	"dat250-project-group-1/feedapp/middleware"
	"dat250-project-group-1/feedapp/subscriber"

	"github.com/gin-gonic/contrib/static"
	"github.com/gin-gonic/gin"
)

func main() {
	// Initialize database connection
	db := config.InitDatabase()

	// Initialize firebase auth
	auth := config.InitFirebase()

	// Initialize a gin router engine
	router := gin.Default()

	// Serve flutter web
	router.Use(static.Serve("/", static.LocalFile("./static", true)))

	// Enable cors support
	router.Use(middleware.Cors)

	// Registrer middlewares
	router.Use(func(c *gin.Context) {
		c.Set("db", db)
		c.Set("auth", auth)
	})

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
		users.GET("", controllers.GetUser)
	}

	polls := router.Group("/polls")
	polls.Use(middleware.Auth)
	{
		polls.POST("", controllers.PostPoll)
		polls.GET("/:code", controllers.GetPoll)
		polls.PUT("/open/:id", controllers.OpenPoll)
		polls.PUT("/end/:id", controllers.EndPoll)
		polls.DELETE("/:id", controllers.DeletePoll)
	}

	votes := router.Group("/votes")
	votes.Use(middleware.Auth)
	{
		votes.POST("", controllers.PostVote)
	}

	public := router.Group("/public")
	{
		public.GET("/polls", controllers.GetPublicPolls)
		public.GET("polls/:code", controllers.GetPublicPoll)
		public.POST("/vote", controllers.PostPublicVote)
	}

	iot := router.Group("/iot")
	{
		iot.GET("/poll/:code", controllers.GetPollForIotDevice)
		iot.POST("/device", controllers.PostIotDevice)
		iot.POST("/votes", controllers.PostIotVotes)
	}

	// Listen to messages from message broker
	go subscriber.Subscribe()

	// Start the server on port 8080
	router.Run()
}
