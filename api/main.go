package main

import (
	"dat250-project-group-1/feedapp/controllers"
	"dat250-project-group-1/feedapp/data"

	"github.com/gin-gonic/gin"
)

// App is an API
type App struct {
	users controllers.UserController
	polls controllers.PollController
	votes controllers.VoteController
}

func main() {
	db := data.NewConnection()
	app := &App{
		users: controllers.UserController{Repo: db},
		polls: controllers.PollController{Repo: db},
		votes: controllers.VoteController{Repo: db},
	}

	router := gin.Default()

	users := router.Group("/users")
	{
		users.GET("", controllers.GetUsers(app.users))
		users.GET("/:id", controllers.GetUser(app.users))
		users.POST("", controllers.PostUser(app.users))
		users.PUT("/:id", controllers.PutUser(app.users))
		users.DELETE("/:id", controllers.DeleteUser(app.users))
	}

	polls := router.Group("/polls")
	{
		polls.GET("", controllers.GetPolls(app.polls))
		polls.GET("/:id", controllers.GetPoll(app.polls))
		polls.POST("", controllers.PostPoll(app.polls))
		polls.PUT("/:id", controllers.PutPoll(app.polls))
		polls.DELETE("/:id", controllers.DeletePoll(app.polls))
	}

	votes := router.Group("/votes")
	{
		votes.GET("", controllers.GetVotes(app.votes))
		votes.GET("/:id", controllers.GetVote(app.votes))
		votes.POST("", controllers.PostVote(app.votes))
		votes.PUT("/:id", controllers.PutVote(app.votes))
		votes.DELETE("/:id", controllers.DeleteVote(app.votes))
	}

	router.Run()

	defer db.CloseConnection()
}
