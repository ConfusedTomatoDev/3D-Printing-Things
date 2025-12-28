@echo off
REM Disable command echoing to keep output clean

setlocal enabledelayedexpansion
REM Enable delayed variable expansion (needed to update/set variables within loops)

REM Loop through all directories (folders) in the current folder
for /d %%F in (*) do (
    REM Check if the folder contains at least one frame image (frame000001.jpg)
    if exist "%%F\frame000001.jpg" (
        echo Processing folder: %%F

        set "lastfile="
        REM Initialize a variable to store the name of the last (highest-numbered) frame

        REM Loop through all JPG files named like frame*.jpg in the current folder
        for %%I in ("%%F\frame*.jpg") do (
            set "current=%%~nxI"
            REM Extract just the file name (not full path) into 'current'
            set "lastfile=!current!"
            REM Save current filename into 'lastfile' (last assignment wins, so we get the final one in the list)
        )

        REM Construct full path to the last image file found
        set "lastpath=%%F\!lastfile!"

        REM Set the name for the output snapshot image (e.g., foldername_last.jpg)
        set "snapshot=%%F_last.jpg"

        REM Create a video from the sequence of images using FFmpeg
        REM -framerate 30: sets frame rate to 30 FPS
        REM -i "%%F\frame%%06d.jpg": input image pattern (e.g., frame000001.jpg to frame000483.jpg)
        REM -vf "hflip,vflip": apply horizontal and vertical flips (180° rotation)
        REM -c:v libx264: encode video using H.264 codec
        REM -pix_fmt yuv420p: ensure compatibility with most video players
        REM "%%F.mp4": output video file named after the folder
        ffmpeg -y -framerate 30 -i "%%F\frame%%06d.jpg" -vf "hflip,vflip" -c:v libx264 -pix_fmt yuv420p "%%F.mp4"

        REM Create a snapshot image from the last frame
        REM -pattern_type none: treat input as a single file, not a numbered sequence
        REM -i "!lastpath!": input file path to the last image
        REM -vf "hflip,vflip": flip the snapshot the same way as the video
        REM -frames:v 1: only process one frame
        REM -f image2: output format as a still image (e.g., .jpg)
        REM "!snapshot!": final output file name
        ffmpeg -y -pattern_type none -i "!lastpath!" -vf "hflip,vflip" -frames:v 1 -f image2 "!snapshot!"
    ) else (
        REM Skip folder if it doesn't contain any frame images
        echo Skipping folder: %%F (no frame000001.jpg found)
    )
)

echo All done.
pause
REM Keeps the terminal window open so you can see the output before it closes
