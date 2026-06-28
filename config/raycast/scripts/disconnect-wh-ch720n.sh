#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Disconnect WH-CH720N
# @raycast.mode compact
# @raycast.icon 🔌

DEVICE_MAC="a8-e6-e8-46-be-b2"
TIMEOUT=5

wait_for_disconnection() {
  for ((i=0; i<TIMEOUT; i++)); do
    ! blueutil --connected | grep -iq "$DEVICE_MAC" && return 0
    sleep 1
  done
  return 1
}

blueutil --disconnect "$DEVICE_MAC"
if wait_for_disconnection; then
  echo "🔌 Disconnected"
else
  echo "❌ Failed to disconnect"
fi
