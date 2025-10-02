package main

import (
	"encoding/json"
	"fmt"
	"log/slog"
	"net/http"
	"os"
	"strings"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

type TTSRequest struct {
	SpeakerID string `json:"speaker_id"`
	Text      string `json:"text"`
}

type ErrorResponse struct {
	Error string `json:"error"`
}

func main() {
	// TODO: Create config object
	logger := slog.New(slog.NewTextHandler(os.Stdout, nil))
	logger.Info("Hello World")

	router := chi.NewRouter()
	// TODO: Wireup with slog
	router.Use(middleware.Logger)

	router.Get("/", func(wri http.ResponseWriter, req *http.Request) {
		wri.Write([]byte("Hello World"))
	})
	router.Post("/tts/synthesize", func(wri http.ResponseWriter, req *http.Request) {
		var tts TTSRequest
		if err := json.NewDecoder(req.Body).Decode(&tts); err != nil {
			wri.WriteHeader(http.StatusBadRequest)
			error := fmt.Sprintf("Invalid TTS request: %v", err)
			if err := json.NewEncoder(wri).Encode(ErrorResponse{Error: error}); err != nil {
				logger.Error("Failed to Marshal error: %v", err)
			}
			return;
		}

		if strings.Contains(strings.ToLower(tts.Text), "you") {
			wri.Write([]byte("You too :3"))
		} else {
			wri.Write([]byte("Why not?"))
		}
	})

	http.ListenAndServe(":9000", router)
}
