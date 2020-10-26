package config

import (
	"context"

	firebase "firebase.google.com/go"
	"firebase.google.com/go/auth"

	"google.golang.org/api/option"
)

// InitFirebase initialize the firebase connection
func InitFirebase() *auth.Client {
	opt := option.WithCredentialsFile("/Users/maritlund/utvikling/DAT250/prosjekt/creds/feedapp-dde0b-firebase-adminsdk-u9xmw-8548a93ada.json")
	app, err := firebase.NewApp(context.Background(), nil, opt)
	if err != nil {
		panic("Firebase load error")
	}

	auth, err := app.Auth(context.Background())
	if err != nil {
		panic("Firebase load error")
	}
	return auth
}