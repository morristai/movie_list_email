package main

import (
	"crypto/tls"

	"gopkg.in/mail.v2"
)

func main() {
	m := mail.NewMessage()
	m.SetHeader("From", "diaper151@gmail.com")
	m.SetHeader("To", "diaper151@gmail.com")
	// m.SetAddressHeader("Cc", "dan@example.com", "Dan")
	m.SetHeader("Subject", "Movie List")
	// m.SetBody("text/html", "Hello <b>Bob</b> and <i>Cora</i>!")
	m.Attach("./movie_list.txt")

	d := mail.NewDialer("smtp.gmail.com", 587, "diaper151@gmail.com", "morris050")
	d.TLSConfig = &tls.Config{InsecureSkipVerify: true}
	d.StartTLSPolicy = mail.MandatoryStartTLS

	// Send emails using d.
	if err := d.DialAndSend(m); err != nil {
		panic(err)
	}
}
