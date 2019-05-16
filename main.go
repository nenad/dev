package main

import (
	"context"
	"flag"
	"fmt"
	"log"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

// HandleRequest responds to a request from lambda
func HandleRequest(ctx context.Context) (events.APIGatewayProxyResponse, error) {
	html, err := getHTML(struct {
		Name string
	}{
		Name: "Nenad",
	})

	if err != nil {
		log.Fatal(err)
	}

	resp := events.APIGatewayProxyResponse{
		Body: html,
		Headers: map[string]string{
			"Content-Type": "text/html",
		},
		StatusCode: 200,
	}

	return resp, nil
}

func main() {
	isCLI := flag.Bool("cli", false, "Run it in CLI instead of lambda")
	flag.Parse()

	if !*isCLI {
		lambda.Start(HandleRequest)
		return
	}

	response, _ := HandleRequest(context.Background())
	fmt.Println(response)
}
