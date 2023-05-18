#!/bin/sh
timestamp=$(date "+%Y.%m.%d-%H.%M.%S")
file="~/Videos/${timestamp}.mp4"
flag_file="/tmp/recording.flag"
if [ -f "$flag_file" ]; then
  echo "Recording is already in progress. Stopping..."
  pid=$(cat "$flag_file")
  pkill "$pid"
  rm "$flag_file"
else
  echo "Starting recording..."
  wf-recorder --audio=alsa_output.pci-0000_0f_00.4.iec958-stereo.monitor --device=/dev/dri/renderD128 -F fps=60 --codec=h264_qsv -p b=3.5M -g "$(slurp)" -f "$flag_file" && echo $! >> "$flag_file"
fi
