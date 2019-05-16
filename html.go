package main

import (
	"bytes"
	"html/template"
)

func getHTML(data interface{}) (string, error) {
	t, err := template.ParseFiles("templates/resume.html")
	if err != nil {
		return "", err
	}

	html := &bytes.Buffer{}
	err = t.ExecuteTemplate(html, "resume.html", data)

	if err != nil {
		return "", err
	}

	return html.String(), nil
}
