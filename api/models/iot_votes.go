package models

// IotVotes represent votes collected by an iot device
type IotVotes struct {
	ID          int
	CountYes    int
	CountNo     int
	PollID      int
	IotDeviceID int
}
