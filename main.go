package main

import (
	"context"
	"flag"
	"fmt"
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

type MyEvent struct {
	Name string `json:"name"`
}

func HandleRequest(ctx context.Context, name MyEvent) (events.APIGatewayProxyResponse, error) {
	resp := events.APIGatewayProxyResponse{
		Body: fmt.Sprintf("<html><head><title>Hello %s</title></head><body><h1>WORKS!</h1></body></html>", name.Name),
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

	response, _ := HandleRequest(context.Background(), MyEvent{Name:"Nenad"})
	fmt.Println(response)
}
