---
name: transcribe
description: >-
  Transcribe audio files (podcasts, MP3s, interviews) using OpenAI Whisper.
  Use when the user wants to transcribe a podcast, audio file, or MP3. Also
  use when asked to "listen to" a podcast or audio.
license: MIT
metadata:
  author: spatie
  version: "0.0.1"
---

# Audio Transcription

Transcribe audio files using OpenAI Whisper (installed via Homebrew).

## Prerequisites

- `whisper` CLI must be installed: `brew install openai-whisper`

## How to transcribe

### 1. Get the audio file

If given a URL, download it:
```bash
curl -L -o /tmp/audio-file.mp3 "URL_HERE"
```

If given a podcast name/episode, search for the RSS feed or episode page to find the MP3 URL. Podcast hosting platforms like Transistor, Buzzsprout, Libsyn typically have direct MP3 URLs in their episode pages.

### 2. Run Whisper

```bash
whisper /tmp/audio-file.mp3 --model small --language en --output_dir /tmp/whisper-output --output_format txt
```

Available models (speed vs accuracy tradeoff):
- `tiny` - fastest, least accurate
- `base` - fast, decent accuracy
- `small` - good balance (recommended default)
- `medium` - slower, better accuracy
- `large` - slowest, best accuracy

For non-English audio, omit the `--language` flag or specify the correct language code.

### 3. Read the output

The transcript will be at `/tmp/whisper-output/audio-file.txt`

## Tips

- For long files (1h+), use `small` model to keep it reasonable
- For short files or when accuracy matters, use `medium` or `large`
- The first run downloads the model weights, subsequent runs are faster
- Output formats available: txt, vtt, srt, tsv, json
- For subtitles, use `--output_format srt`
