package models

// IotDevice represent an iot device
type IotDevice struct {
	ID       int
	Name     string
	IotVotes []IotVotes
}
