package data

import (
	"dat250-project-group-1/feedapp/models"

	"github.com/go-pg/pg"
	"github.com/go-pg/pg/orm"
)

// Connection has a postgres connection
type Connection struct {
	*pg.DB
}

// NewConnection make a connection to the postgres database
func NewConnection() *Connection {
	db := pg.Connect(&pg.Options{
		Addr:     "data1.hib.no:5432",
		User:     "h180312",
		Password: "pass",
		Database: "h180312",
	})
	createSchema(db)

	return &Connection{db}
}

// CloseConnection closes the connection to the database
func (c *Connection) CloseConnection() {
	c.Close()
}

func createSchema(db *pg.DB) {
	//db.Exec("drop schema dat250 cascade;create schema dat250")

	models := []interface{}{
		(*models.User)(nil),
		(*models.Poll)(nil),
		(*models.Vote)(nil),
		(*models.IotDevice)(nil),
		(*models.IotVotes)(nil),
	}

	for _, model := range models {
		err := db.Model(model).CreateTable(&orm.CreateTableOptions{
			IfNotExists:   true,
			FKConstraints: true,
		})
		if err != nil {
			panic(err)
		}
	}

	/*file, err := ioutil.ReadFile("testdata.sql")

	if err != nil {
		panic(err)
	}

	requests := strings.Split(string(file), ";")

	for _, request := range requests {
		db.Exec(request)
	}*/
}
