#!/bin/bash

# Function to show help
show_help() {
    echo "Usage: ai [options] [-m model]"
    echo "Options:"
    echo "  -i              Install AI model"
    echo "  -a              Show available AI models"
    echo "  -t              Talk with AI in temp/AI folder"
    echo "  -w              Work with AI in current folder"
    echo "  -m              Choose model alias:"
    echo "                  g|G|gemini - Use Gemini"
    echo "                  q|Q|qodo   - Use Qodo"
    echo "                  o|O|opencode - Use OpenCode"
    echo "  -h, --help      Show this help message"
    echo "  -v, --version   Show version information"
    echo "Examples:"
    echo "  ai -t -m [<model>]               # Chat in /tmp/AI using AI Model"
    echo "  ai -w -m [<model>]               # Chat in current folder using AI Model"
}

# Defaults and state
action=""          # "chat" when -t or -w selected
target_dir=""      # "/tmp/AI" for -t, "$PWD" for -w

# Map model alias to command
resolve_model_cmd() {
    local model_input="$1"
    
    case "$model_input" in
        ""|g|G|gemini|Gemini)
            echo "gemini"
            ;;
        q|Q|qodo|Qodo)
            echo "qodo --chat"
            ;;
        o|O|opencode|OpenCode)
            echo "opencode"
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
            echo "AI version 1.4"
            exit 0
            ;;
    esac
done

# Selected model (via -m), default resolved later
MODEL_INPUT=""

# Get flags from user (options only)
while getopts ":iathwvm:" opt; do
    case $opt in
        i)
            echo "Installing AI models..."
            echo "sudo npm install "
            echo " -> Installing Gemini"
            echo "sudo npm install -g @google/gemini-cli"
            echo " -> Installing Qodo"
            echo "sudo npm install -g @qodo/command"
            echo " -> Installing OpenCode"
            echo "sudo npm i -g opencode-ai@latest"
            exit 0
            ;;
        a)
            echo "Available AI models:"
            echo " - Gemini [Use: -m g | -m G | -m gemini]"
            echo " - Qodo [Use: -m q | -m Q | -m qodo]"
            echo " - OpenCode [Use: -m o | -m O | -m opencode]"
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
    MODEL_INPUT="g"  # Default to gemini
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
        exec $MODEL_CMD
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