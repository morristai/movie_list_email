package main

import (
    "crypto/tls"
    "fmt"
    "gopkg.in/mail.v2"
    "os"
    "path/filepath"
)

func main() {
	files, err := WalkMatch("/home/morris/Videos", "*.txt")
        if err != nil{
		panic(err)
	}
	m := mail.NewMessage()
	m.SetHeader("From", "diaper151@gmail.com")
	m.SetHeader("To", "diaper151@gmail.com")
	// m.SetAddressHeader("Cc", "dan@example.com", "Dan")
	m.SetHeader("Subject", "Movie List")
	// m.SetBody("text/html", "Hello <b>Bob</b> and <i>Cora</i>!")
	m.Attach(files[0])

	d := mail.NewDialer("smtp.gmail.com", 587, "diaper151@gmail.com", "yourpassword")
	d.TLSConfig = &tls.Config{InsecureSkipVerify: true}
	d.StartTLSPolicy = mail.MandatoryStartTLS

	// Send emails using d.
	if err := d.DialAndSend(m); err != nil {
		panic(err)
	}
}

func WalkMatch(root, pattern string) ([]string, error) {
    var matches []string
    err := filepath.Walk(root, func(path string, info os.FileInfo, err error) error {
        if err != nil {
            return err
        }
        if info.IsDir() {
            return nil
        }
        if matched, err := filepath.Match(pattern, filepath.Base(path)); err != nil {
            return err
        } else if matched {
            matches = append(matches, path)
        }
        return nil
    })
    if err != nil {
        return nil, err
    }
    return matches, nil
}
