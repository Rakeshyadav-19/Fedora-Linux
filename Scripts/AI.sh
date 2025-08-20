#!/bin/bash

# Function to show help
show_help() {
    echo "Usage: ai [options] [-m model]"
    echo "Options:"
    echo "  -a show available AI models"
    echo "  -t talk with AI in temp/AI folder"
    echo "  -w Work with ai in current folder"
    echo "  -m model        Choose model alias (e.g., G, g, gemini)"
    echo "  -h, --help      Show this help message"
    echo "  -v, --version   Show version information"
    echo "Examples:"
    echo "  ai -a"
    echo "  ai -t -m G      # Chat in /tmp/AI using Gemini"
    echo "  ai -w -m g      # Chat in current folder using Gemini"
}

# Defaults and state
action=""          # "chat" when -t or -w selected
target_dir=""      # "/tmp/AI" for -t, "$PWD" for -w

# Map model alias to command
resolve_model_cmd() {
    local model_input="$1"
    case "$model_input" in
        ""|G|g|Gemini|gemini)
            echo "gemini"
            ;;
        *)
            echo ""  # unknown
            ;;
    esac
}

# Handle long options early
for arg in "$@"; do
    case "$arg" in
        --help)
            show_help
            exit 0
            ;;
        --version)
            echo "AI version 1.0"
            exit 0
            ;;
    esac
done

# Selected model (via -m), default resolved later
MODEL_INPUT=""

# Get flags from user (options only)
while getopts ":athwvm:" opt; do
    case $opt in
        a)
            echo "Available AI models:"
            echo " - Gemini [Use: -m G | -m g | -m gemini]"
            exit 0
            ;;
        t)
            action="chat"
            target_dir="/tmp/AI"
            ;;
        w)
            action="chat"
            target_dir="$PWD"
            ;;
        m)
            MODEL_INPUT="$OPTARG"
            ;;
        h)
            show_help
            exit 0
            ;;
        v)
            echo "AI version 1.0"
            exit 0
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            show_help
            exit 1
            ;;
    esac
done

# Shift parsed options (no positional args expected)
shift $((OPTIND - 1))

# Default model if not provided
if [ -z "$MODEL_INPUT" ]; then
    MODEL_INPUT="G"
fi
MODEL_CMD=$(resolve_model_cmd "$MODEL_INPUT")

if [ -z "$MODEL_CMD" ]; then
    echo "Unknown model: '$MODEL_INPUT'" >&2
    echo "Use -a to list available models."
    exit 1
fi

# Execute action after parsing all inputs
case "$action" in
    chat)
        if [ "$target_dir" = "/tmp/AI" ]; then
            echo "Starting chat with AI in temp/AI folder"
            sleep 1
            # Ensure /tmp/AI exists
            if [ ! -d /tmp/AI ]; then
                mkdir /tmp/AI
            fi
            cd /tmp/AI || { echo "Failed to cd to /tmp/AI" >&2; exit 1; }
        elif [ -n "$target_dir" ]; then
            echo "Starting chat with AI in current folder"
            sleep 1
            cd "$target_dir" || { echo "Failed to cd to '$target_dir'" >&2; exit 1; }
        else
            echo "No target directory specified. Use -t or -w."
            show_help
            exit 1
        fi
        # Invoke selected model CLI
        exec "$MODEL_CMD"
        ;;
    "")
        # No action selected; just show help
        show_help
        ;;
    *)
        echo "Unknown action '$action'" >&2
        exit 1
        ;;
esac