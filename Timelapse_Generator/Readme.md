The batch script will process directories containing JPG images and create timelapse videos of jpg snapshots using FFmpeg.

Use: For when you use the "Save Frames" option for your 3D printer timelapse settings, or have a folder of still shot jpg images you want to convert into a .mp4 video file.

Run: 
1. Create a main working folder
2. Place all timelapse images into seporated isolated folders under the main working folder.
3. Place the batch file in the working folder.
4. Download nad copy the contents of ffmpeg bin folder directly into the same working folder, or update the batch file to include the full path to ffmpeg.exe folder.
5. Open a DOS window and run the batch file.

The batch file will process each isolated folder for .jpg files and create a new video file in the working folder, including a matching end screen shot jpg image allowing you to identify the contents of the mp4 file.
At the end of the run, the batch will pause in order for you to review the results.  

CRTL-C to exit.


