package config

import (
	"context"

	firebase "firebase.google.com/go"
	"firebase.google.com/go/auth"
)

// InitFirebase initialize the firebase connection
func InitFirebase() *auth.Client {
	app, err := firebase.NewApp(context.Background(), nil)
	if err != nil {
		panic("Firebase load error")
	}

	auth, err := app.Auth(context.Background())
	if err != nil {
		panic("Firebase load error")
	}
	return auth
}