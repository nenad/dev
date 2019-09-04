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
			"Strict-Transport-Security": "max-age=31536000; includeSubDomains",
			"Content-Security-Policy": "default-src *; img-src 'self'; script-src 'unsafe-inline'; style-src 'unsafe-inline'; form-action 'none'; base-uri 'self'; frame-ancestors 'self'",
			"X-Frame-Options": "SAMEORIGIN",
			"X-XSS-Protection": "1; mode=block",
			"X-Content-Type-Options": "nosniff",
			"Referrer-Policy": "same-origin",
			"Feature-Policy": "accelerometer 'none';ambient-light-sensor 'none';autoplay 'none';camera 'none';encrypted-media 'none';fullscreen 'self';geolocation 'self';gyroscope 'none';magnetometer 'none';microphone 'none';midi 'none';payment 'self';picture-in-picture 'none';speaker 'self';sync-xhr 'none';usb 'none';vibrate 'none';vr 'none';",
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
