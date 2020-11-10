package main

import (
	"bytes"
	"dat250-project-group-1/iot/models"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
)

var host = "http://localhost:8080"

func main() {
	fmt.Print("\033[H\033[2J")

	var name string
	fmt.Println("Enter name of iot device:")
	fmt.Scan(&name)

	body, err := json.Marshal(&models.IotDevice{Name: name})
	if err != nil {
		log.Fatal(err.Error())
	}

	resp, err := http.Post(host+"/iot/devices", "application/json", bytes.NewBuffer(body))
	if err != nil {
		log.Fatal(err.Error())
	}

	var device models.IotDevice
	defer resp.Body.Close()
	body, err = ioutil.ReadAll(resp.Body)

	err = json.Unmarshal(body, &device)
	if err != nil {
		log.Fatal(err.Error())
	}

	fmt.Print("\033[H\033[2J")

	var code string
	fmt.Println("Enter code of the poll you would like to connect this iot device to:")
	fmt.Scan(&code)

	poll := getPoll(code)
	var votes models.IotVotes
	votes.PollID = poll.ID
	votes.IotDeviceID = device.ID

	for {
		fmt.Print("\033[H\033[2J")
		var ans string
		fmt.Println(poll.Question + (" (y/n)"))
		fmt.Scan(&ans)
		switch ans {
		case "y":
			votes.CountYes++
		case "n":
			votes.CountNo++
		case "s":
			votes = postVotes(&votes)
			votes.PollID = poll.ID
			votes.IotDeviceID = device.ID
		case "v":
			poll = getPoll(code)

			var dummy string
			fmt.Print("\033[H\033[2J")
			fmt.Printf("Yes: %d, No: %d \n", poll.CountYes+votes.CountYes, poll.CountNo+votes.CountNo)
			fmt.Println("Enter any key to continue")
			fmt.Scan(&dummy)

		case "q":
			os.Exit(0)
		}
	}
}

func getPoll(code string) models.Poll {
	var poll models.Poll
	resp, err := http.Get(host + "/public/polls/" + code)
	if err != nil {
		log.Fatal(err.Error())
	}

	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)

	err = json.Unmarshal(body, &poll)
	if err != nil {
		log.Fatal(err.Error())
	}
	if poll.ID == 0 {
		log.Fatal(("Poll not found"))
	}

	return poll
}

func postVotes(votes *models.IotVotes) models.IotVotes {
	votesBody, err := json.Marshal(votes)
	if err != nil {
		fmt.Print(err.Error())
	}
	_, err = http.Post(host+"/iot/votes", "application/json", bytes.NewBuffer(votesBody))
	return models.IotVotes{}
}
