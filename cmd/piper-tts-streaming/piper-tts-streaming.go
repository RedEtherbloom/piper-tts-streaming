package main

import (
	"log/slog"
	"net/http"
	"os"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

func main() {
	logger := slog.New(slog.NewTextHandler(os.Stdout, nil))
	logger.Info("Hello World")

	router := chi.NewRouter()
	// TODO: Wireup with slog
	router.Use(middleware.Logger)

	router.Get("/", func(wri http.ResponseWriter, req *http.Request) {
    wri.Write([]byte("Hello World"))
	})
}
