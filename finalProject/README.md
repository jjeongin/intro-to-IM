# ***Light, Space, and Us*** (2021)
### Description:

Light determines how we perceive the visual world around us and our place in this ever-changing space that we belong in. The animation changes in real-time based on two elements: the images of viewers and the amount of light coming into the LDR sensor on Arduino. By covering or uncovering the sensor, viewers are invited to this imaginary three-dimensional space that will encourage them to reimagine the relationship between light, space, and us.

- See [journal.md](journal.md) for the detailed creative process.

### Notes on Exhibition:
My final work was exhibited in IM Showcase 2021 at NYUAD's Art Center on Dec. 15th. For the final setup, I used an extra monitor, Kinect, and Arduino with my MacBook Pro.

### Demo:
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
