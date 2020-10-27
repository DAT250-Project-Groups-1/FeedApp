package subscriber

import (
	"context"
	"dat250-project-group-1/feedapp/models"
	"encoding/json"
	"fmt"

	firebase "firebase.google.com/go"
	"github.com/streadway/amqp"
)

func failOnError(err error, msg string) {
	if err != nil {
		fmt.Printf("%s: %s", msg, err)
	}
}

// Subscribe to messages published to the message broker
func Subscribe() {
	app, err := firebase.NewApp(context.Background(), nil)
	if err != nil {
		panic("Firebase load error")
	}

	client, err := app.Firestore(context.Background())
	if err != nil {
		panic("Firestore load error")
	}
	defer client.Close()

	conn, err := amqp.Dial("amqps://ktupewlq:T8mdER8Dn2PLWq_UXDKHxUILMnhoIHnR@hawk.rmq.cloudamqp.com/ktupewlq")
	failOnError(err, "Failed to connect to RabbitMQ")
	defer conn.Close()

	ch, err := conn.Channel()
	failOnError(err, "Failed to open a channel")
	defer ch.Close()

	err = ch.ExchangeDeclare(
		"polls",
		"fanout",
		true,
		false,
		false,
		false,
		nil,
	)
	failOnError(err, "Failed to declare an exchange")

	q, err := ch.QueueDeclare(
		"",
		false,
		false,
		true,
		false,
		nil,
	)
	failOnError(err, "Failed to declare a queue")

	err = ch.QueueBind(
		q.Name,
		"",
		"polls",
		false,
		nil)
	failOnError(err, "Failed to bind a queue")

	msgs, err := ch.Consume(
		q.Name,
		"",
		true,
		false,
		false,
		false,
		nil,
	)
	failOnError(err, "Failed to register a consumer")

	forever := make(chan bool)

	for msg := range msgs {
		var poll models.Poll
		err := json.Unmarshal(msg.Body, &poll)
		if err != nil {
			fmt.Printf("Failed converting json to poll: %v", err)
		}

		_, _, err = client.Collection("polls").Add(context.Background(), poll)

		if err != nil {
			fmt.Printf("Failed adding poll to firestore: %v", err)
		}
	}

	<-forever
}
