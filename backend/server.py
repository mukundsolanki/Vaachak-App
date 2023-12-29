import cv2
import threading
import time
import os
from flask import Flask, request

app = Flask(__name__)

# Global variable to indicate whether to open the camera or not
open_camera = False

# Function to open the camera for 5 seconds and record video
def open_camera_for_5_seconds(video_name):
    global open_camera
    open_camera = True

    # Open the camera
    cap = cv2.VideoCapture(0)

    # Create a VideoWriter object to save the video
    fourcc = cv2.VideoWriter_fourcc(*'XVID')
    out = cv2.VideoWriter(video_name, fourcc, 20.0, (640, 480))

    # Set a timeout of 5 seconds
    timeout = time.time() + 5

    # Capture and display frames for 5 seconds
    while time.time() < timeout:
        ret, frame = cap.read()
        cv2.imshow("Camera", frame)

        # Write the frame to the video file
        out.write(frame)

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    # Release the camera, close the window, and release the VideoWriter
    cap.release()
    out.release()
    cv2.destroyAllWindows()

    # Reset the global variable
    open_camera = False

# Function to handle the text received request
@app.route('/receive-text', methods=['POST'])
def receive_text():
    try:
        received_text = request.form['text']
        print('Received text:', received_text)
        print('Text received successfully')

        # Start a new thread to open the camera and record video
        video_name = f"video/{received_text}.avi"
        threading.Thread(target=open_camera_for_5_seconds, args=(video_name,)).start()
        print('Camera started successfully')

        return 'Text received successfully!', 200
    except KeyError:
        return 'Text parameter missing in the request', 400

if __name__ == '__main__':
    # Create the 'video' directory if it doesn't exist
    if not os.path.exists('video'):
        os.makedirs('video')

    app.run(host='192.168.1.5', port=8000)
