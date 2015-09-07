package main

import (
	"encoding/json"
	"fmt"
	"os"

	"gopkg.in/qml.v1"
)

type Snippet struct {
	Title string
	Color string
	Start int
	Row   int
	Ticks int
}

func (s *Snippet) SetRow(row int) {
	if row < 0 {
		row = 0
	}
	if row >= 8 {
		row = 7
	}
	s.Row = row
}

func (s *Snippet) SetStart(start int) {
	if start < 0 {
		start = 0
	}

	end := s.Start + s.Ticks

	if start >= end {
		start = end - 1
	}

	s.Start = start
}

func (s *Snippet) SetTicks(ticks int) {
	if ticks < 1 {
		ticks = 1
	}
	s.Ticks = ticks
}

type Timeline struct {
	snippets []*Snippet
	Len      int
}

func (t *Timeline) Snippet(n int) *Snippet {
	return t.snippets[n]
}

func (t *Timeline) AddSnippet(snippet *Snippet) {

	t.snippets = append(t.snippets, snippet)
	t.Len = len(t.snippets)
	qml.Changed(t, &t.Len)
}

func main() {
	if err := qml.Run(run); err != nil {
		fmt.Fprintf(os.Stderr, "error: %v\n", err)
		os.Exit(1)
	}
}

func loadTimeline(filename string) (*Timeline, error) {

	snippets := make([]Snippet, 0, 100)

	f, err := os.Open(filename)
	if err != nil {
		return nil, err
	}

	defer f.Close()

	err = json.NewDecoder(f).Decode(&snippets)
	if err != nil {
		return nil, err
	}

	timeline := &Timeline{}
	for n := range snippets {
		timeline.AddSnippet(&snippets[n])
	}

	return timeline, nil
}

func run() error {
	engine := qml.NewEngine()
	context := engine.Context()
	timeline, err := loadTimeline("example.json")
	if err != nil {
		return err
	}

	context.SetVar("timelineData", timeline)

	controls, err := engine.LoadFile("main.qml")
	if err != nil {
		return err
	}

	window := controls.CreateWindow(nil)

	window.Show()
	window.Wait()
	return nil
}
