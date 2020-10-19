package config

import (
	"dat250-project-group-1/feedapp/models"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

// InitDatabase initialize the database connection
func InitDatabase() *gorm.DB {

	dsn := "host=data1.hib.no port=5432 user=h180312 dbname=h180312 password=pass"
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		panic("Failed to connect to database!")
	}

	err = db.AutoMigrate(&models.User{}, &models.Poll{}, &models.Vote{}, &models.IotDevice{}, &models.IotVotes{})
	if err != nil {
		panic("Failed to migrate database!")
	}
	return db
}
