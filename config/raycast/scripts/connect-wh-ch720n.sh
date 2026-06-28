#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Connect WH-CH720N
# @raycast.mode compact
# @raycast.icon 🎧

DEVICE_MAC="a8-e6-e8-46-be-b2"
DEVICE_NAME="WH-CH720N"
TIMEOUT=5

wait_for_device() {
  for ((i=0; i<TIMEOUT; i++)); do
    blueutil --connected | grep -iq "$DEVICE_MAC" && return 0
    sleep 1
  done
  return 1
}

wait_for_audio() {
  for ((i=0; i<TIMEOUT; i++)); do
    SwitchAudioSource -a -t output | grep -Fxq "$DEVICE_NAME" && return 0
    sleep 1
  done
  return 1
}

blueutil --connect "$DEVICE_MAC"
if wait_for_device; then
  echo "🔗 Connected"
  if wait_for_audio; then
    SwitchAudioSource -s "$DEVICE_NAME" -t output && echo "🔊 Output set"
    SwitchAudioSource -s "$DEVICE_NAME" -t input && echo "🎙️ Input set"
  else
    echo "⚠️ Audio device not ready"
  fi
else
  echo "❌ Failed to connect"
fi
