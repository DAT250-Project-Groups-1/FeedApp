package publisher

import (
	"dat250-project-group-1/feedapp/models"
	"encoding/json"
	"fmt"

	"github.com/streadway/amqp"
)

// Publisher can publish an message to the message broker

func failOnError(err error, msg string) {
	if err != nil {
		fmt.Printf("%s: %s", msg, err)
	}
}

// Publish a message to the message broker
func Publish(msg models.Poll) {
	conn, err := amqp.Dial("amqps://ktupewlq:T8mdER8Dn2PLWq_UXDKHxUILMnhoIHnR@hawk.rmq.cloudamqp.com/ktupewlq")
	failOnError(err, "Failed to connect to RabbitMQ")
	defer conn.Close()

	ch, err := conn.Channel()
	failOnError(err, "Failed to open a channel")
	defer ch.Close()

	body, err := json.Marshal(msg)
	failOnError(err, "Failed to convert struct to json")
	err = ch.Publish(
		"polls",
		"",
		false,
		false,
		amqp.Publishing{
			ContentType: "text/plain",
			Body:        body,
		})
}
