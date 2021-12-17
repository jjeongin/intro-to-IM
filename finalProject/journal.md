# Final Project Prompt

#### Concept
Generative artwork with the theme of light & space with Processing using user input from Arduino photo resister.

Inspiration (the exhibition I have visited in [Arte Museum, South Korea](https://artemuseum.com/)) :


#### Arduino
Arduino program will allow users to control the graphic/animation generated from Processing using photo resister as analog input. The program will send the light information to the Processing program and also visualize the brightness of the input light with LEDs using digital output. ( + Arduino program might also play interesting background music with digital output. )

#### Processing
If the light is bright, Processing program will present animation inspired by the bright space scape. As the light gets deemer, the graphic will change accordingly.

#### Challenges
Trickiest & most essential part will be to make dynamic and interesting random-generated graphic on Processing. To achieve this, I plan to research other generative artworks and experiment to find the interesting graphic.


# DEC. 7th
### Biggest Challenge:
My initial plan was to use **live video captures** of audiences from cameras and use them to generate 3D graphics to make the piece more interactive & interesting. The problem was that Processing doesn't yet allow to use video capture when using other renderers (OPENGL which I need for 3D Graphic) than default! I tried almost every possible ways that I could imagine & find from internet but haven't found a solution yet. Here are some methods I tried:
- Using video.start() and video.stop() to restart and stop video capturing everytime I need to capture a new image.
- Using hint() to enable and disable z-buffers
- Using PGraphic temporarily for 3D graphics
- Using separate Processing windows with PApplet

In the end, I gave up on using video capture and 3D in the same sketch and decided to use sample capture images that I got from my webcam during developing process. Later, I will try to get real time images from the camera using other ways than directly using Processing.

### Current Stage and Demos:
So I currently have two versions of Processing codes using **(1) static images with 3D graphics** and **(2) live video captures with 2D graphics**, but I am leaning towards the first version. 3D version adjusts depth of the dots based on the LDR sensor value.

- 3D Ver.

<img src="3d_screenshot.png" width="800px">

https://user-images.githubusercontent.com/68997923/144938448-a8eaa0c3-ad52-4cec-90d1-c7ed70f4fac2.mov


- Live Viedo Ver.


Using Dots

<img src="live_vid_dots.png" width="800px">

Using Lines

<img src="live_vid_line.png" width="800px">

### Further Improvements:
My main goal for this project is to visualize the relationship between *light, time, and us* and come up with an interesting visualization that changes in real time based on two elements: the images of viewers and the amount of light coming into the LDR sensor. To achieve this, I think I will have to work more on following things before the deadline.
- Making rotation of the graphic smoother & automatic
- What should the **LDR sensor** do? Which value should it adjust? (currently decides depth)
- Obtaining real time images from the camera and figuring out how to connect/transition/layer from the previous image to the new one.
- How to make interaction between users and the LDR sensor more approchable and resillient (custom box that hides rest of the Arduino components and only shows the LDR sensor on the top?) or Adding some LEDs to make the Arduino board itself more visible and interesting
- Maybe some background musics to make it more immersive?

### Feedback from User Testing:
- The graphic can be not visible enough & confusing sometimes since dots are small and the rotating speed is slow (only dark background is shown occasionally).
- Furture Improvements: Make dots bigger & adjust the rotating speed

### Extra Equipments:
- Kinect ?
- Large Screen
- LDR box

# DEC. 9th 
I decided to use Kinect for Windows (borrowed from NYUAD IM Lab) for this project. Some library compatibility problems like the following occurred but I managed to solve it through some online research.

## ERROR LOG
- Open Kinect Library didn't work in Processing 4 !
  -  NoClassDefFoundError: /com/sun/jna/Library
  -  Solution: After googling, I referred to [this answer](https://discourse.processing.org/t/processing-4-openkinect/32781) and solved the error by copying jna.jar file in video/library folder to openkinect_processing/library folder.

# Final Exhibition
My final work was exhibited in IM Showcase 2021 at NYUAD's Art Center on Dec. 15th. For the final setup, I connected an extra monitor, Kinect, and Arduino together to my laptop. 

### ***Light, Space, and Us*** (2021)
- Light determines how we perceive the visual world around us and our place in this ever-changing space that we belong in. The animation changes in real-time based on two elements: the images of viewers and the amount of light coming into the LDR sensor on Arduino. By covering or uncovering the sensor, viewers are invited to this imaginary three-dimensional space that will encourage them to reimagine the relationship between light, space, and us.


### Demos:
https://user-images.githubusercontent.com/68997923/146527912-9e428979-2835-46ed-8e7a-5d6ea588f357.mov

<img src="https://user-images.githubusercontent.com/68997923/146528423-c02231d7-c8a5-41d7-8356-c600736a27ac.jpg" width="800px">

### Key Improvements from the Last Feedback:
- I was able to use Kinect to detect the depth of the video and thereby generate more interesting 3d graphic in Processing by using P3D.
- I adjusted the dot size and rotating speed and added short description and instruction on the exhibition site for better user experience.
- I revised the original algorithm I devised to generate the 3d graphic from static images in interactive_light_3d.pde to draw the dots not only with the color of each pixel but also with the newly gathered depth information coming from Kinect.
- To handle the Kinect raw depth information, I referred to Daniel Shiffman's Point Cloud example for Kinect v1.
- The most unexpected challenge on the exhibition site was that the light bulbs above my installation was off the whole time I tested it on the day before the exhibition but on at the real exhibition day ! This made the whole graphic expanded a bit in general that I had to quickly adjust the value of the map() function which is mapping the LDR sensor value to the graphic size.


### Lessons and Future Improvements:
Overall, I really learned a lot while making this work including how to use Kinect and how to devise the best user experience for interactive artworks. I really appreciate having a chance to make this artwork and the IM lab for helping me figure out all the adapter and cable issues and lending all the essential equipments needed for this artwork. 
- For future improvements, I think I can make the algorithm stealthier by using different map() functions based on the current light coming in from the last lesson I learned from the onsite exhibition experience.
- I can also think about the overall graphic a little bit more since a few viewers actually asked me if the graphic is lagging (though the rotating speed was intentionally slowed down to give the viewers time to process the image) and some had a hard time grasping the artwork as there was occasionally only dark background being presented according to the rotation angle.
