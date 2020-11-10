package main

import (
	"bytes"
	"dat250-project-group-1/iot/models"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
)

func main() {
	host := "http://localhost:8080"
	var iotDevice *models.IotDevice
	var iotVotes *models.IotVotes
	var poll *models.Poll

	var name string
	fmt.Println("Enter name of iot device:")
	fmt.Scan(&name)

	body, err := json.Marshal(&models.IotDevice{Name: name})
	if err != nil {
		fmt.Println(err.Error())
		panic("Error Marshalling name of iot device")
	}

	resp, err := http.Get(host + "/iot/devices/" + name)
	if err != nil {
		fmt.Print("Creating new device...")
		resp, err = http.Post(host+"/iot/devices/", "application/json", bytes.NewBuffer(body))
		if err != nil {
			fmt.Println(err.Error())
			panic("linje34")
		}
	}

	defer resp.Body.Close()

	respBody, err := ioutil.ReadAll(resp.Body)

	err = json.Unmarshal(respBody, &iotDevice)
	if err != nil {
		fmt.Println(err.Error())
		panic("hssdsdsdhsh")
	}

	var code string
	fmt.Println("Enter join code of the poll you would like to connect this iot device to:")
	fmt.Scan(&code)

	resp, err = http.Get(host + "/public/polls/" + code)
	if err != nil {
		fmt.Println(err.Error())
		panic("linje 50")
	}

	defer resp.Body.Close()
	respBody, err = ioutil.ReadAll(resp.Body)

	err = json.Unmarshal(respBody, &poll)
	if err != nil {
		fmt.Println(err.Error())
		panic("linje 59")
	}

	iotVotes.PollID = poll.ID

	for {
		var ans string
		fmt.Println(poll.Question)
		fmt.Scan(&ans)
		switch ans {
		case "1":
			iotVotes.CountYes++
		case "0":
			iotVotes.CountNo++
		case "s":
			votesBody, err := json.Marshal(iotVotes)
			if err != nil {
				fmt.Print(err.Error())
			}
			_, err = http.Post(host+"/iot/votes", "application/json", bytes.NewBuffer(votesBody))
			iotVotes = new(models.IotVotes)
		case "v":
			resp, err = http.Get(host + "/iot/poll/" + code)
			if err != nil {
				fmt.Println(err.Error())
			}

			defer resp.Body.Close()
			respBody, err = ioutil.ReadAll(resp.Body)

			err = json.Unmarshal(respBody, &poll)
			if err != nil {
				fmt.Println(err.Error())
			}
		}
	}
}

/*
	POST localhost:8080/iot/device To post the iot device
	POST localhost:8080/oit/votes To post the votes
	GET localhost:8080/iot/poll/:code
*/
