#!/bin/bash

# Audio Switch Script - Toggle between Speaker and Bluetooth
# Uses wpctl (WirePlumber/Pipewire) on Arch Linux

get_current_sink() {
    wpctl get-default
}

get_bluetooth_sink() {
    wpctl status | grep "bluez_output" | head -1 | awk '{print $2}' | tr -d '*'
}

get_speaker_sink() {
    wpctl status | grep -A5 "Sinks:" | grep -v "bluez" | grep "\." | head -1 | awk '{print $2}' | tr -d '[]'
}

switch_audio() {
    current_sink=$(get_current_sink)
    bluetooth_sink=$(get_bluetooth_sink)
    speaker_sink=$(get_speaker_sink)

    echo "Current sink: $current_sink"
    echo "Available Bluetooth sink: $bluetooth_sink"
    echo "Available speaker sink: $speaker_sink"

    # Check if current sink is Bluetooth
    if echo "$current_sink" | grep -q "bluez_output"; then
        echo "Switching to Speaker..."
        if [ -n "$speaker_sink" ]; then
            wpctl set-default "$speaker_sink"
            notify-send "Audio Switched" "Speaker"
        else
            echo "No speaker sink found!"
            exit 1
        fi
    else
        echo "Switching to Bluetooth..."
        if [ -n "$bluetooth_sink" ]; then
            wpctl set-default "$bluetooth_sink"
            notify-send "Audio Switched" "Bluetooth"
        else
            echo "No Bluetooth sink found!"
            exit 1
        fi
    fi
}

list_sinks() {
    echo "Available audio sinks:"
    wpctl status | grep -A10 "Sinks:" | grep "\."
}

case "$1" in
    "toggle"|"")
        switch_audio
        ;;
    "list")
        list_sinks
        ;;
    "bluetooth")
        bluetooth_sink=$(get_bluetooth_sink)
        if [ -n "$bluetooth_sink" ]; then
            wpctl set-default "$bluetooth_sink"
            notify-send "Audio Switched" "Bluetooth"
        else
            echo "No Bluetooth sink found!"
        fi
        ;;
    "speaker")
        speaker_sink=$(get_speaker_sink)
        if [ -n "$speaker_sink" ]; then
            wpctl set-default "$speaker_sink"
            notify-send "Audio Switched" "Speaker"
        else
            echo "No speaker sink found!"
        fi
        ;;
    "help"|"-h"|"--help")
        echo "Usage: $0 [COMMAND]"
        echo "Commands:"
        echo "  toggle      Toggle between speaker and Bluetooth (default)"
        echo "  bluetooth   Switch to Bluetooth audio"
        echo "  speaker     Switch to speaker audio"
        echo "  list        List available audio sinks"
        echo "  help        Show this help message"
        ;;
    *)
        echo "Unknown command: $1"
        echo "Use '$0 help' for usage information"
        exit 1
        ;;
esac