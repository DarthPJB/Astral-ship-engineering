#!/bin/sh
ThePID=$(<"script.pid")
echo "KILLING PID $ThePID"
kill -n 15 $ThePID
sleep 1
echo $$ > script.pid
echo "Pid saved : $$"
killall -9 mplayer
killall -9 xwinwrap
for (( ; ; ))
do
    echo "LAUNCHING PID"
    xwinwrap -b -ov -nf -s -ni -g 1920x1080+0+0 -- mplayer ~/Pictures/wallpaper/infinity.mp4  -autosync 30 -loop 0 -framedrop -wid WID & echo $! > infinity.pid
    xwinwrap -b -ov -nf -s -ni -g 1920x1080+1920+0  -- mplayer ~/Pictures/wallpaper/infinity.mp4 -framedrop -autosync 30 -loop 0 -nosound -wid WID &  echo $! > infinity2.pid
#    xwinwrap -b -ov -nf -s -ni -g 1920x1080+0+0 -- cvlc --video-wallpaper ./Pictures/wallpaper/infinity.mp4 --no-=audio -wid WID & echo $! > infinity2.pid

    CurPID=$(<"infinity.pid")
    echo "pid is $CurPID"
    tail -f --pid=$CurPID -f /dev/null
    echo "looping"
done
