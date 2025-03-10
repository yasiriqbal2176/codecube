package main

import (
	"fmt"
	"net/http"
	"time"
)

func main() {
	// Define the API endpoint
	http.HandleFunc("/current-time", func(w http.ResponseWriter, r *http.Request) {
		// Get the current date and time
		currentTime := time.Now().Format("2006-01-02 15:04:05")

		// Write the response as JSON
		w.Header().Set("Content-Type", "application/json")
		fmt.Fprintf(w, `{"current_time": "%s"}`, currentTime)
	})

	// Start the HTTP server on port 8080
	fmt.Println("Server is running on http://localhost:8080")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		fmt.Printf("Error starting server: %s\n", err)
	}
}