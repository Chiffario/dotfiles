mut vol = (wpctl get-volume @DEFAULT_AUDIO_SINK@ | split column " " | get column2); ($vol.0 | into float) * 100.0
