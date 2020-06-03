# 3D-Reconstruction
3D Reconstruction from 2 image with different view point

# epipolar line and matching point
Image A and Image B are two picture of same object in different view point.
![alt text](https://raw.githubusercontent.com/Mocdo/3D-Reconstruction/master/report_pic/1.JPG "epipolar line")
![alt text](https://raw.githubusercontent.com/Mocdo/3D-Reconstruction/master/report_pic/2.JPG "matching point")
</br>
For each user selected point on image A, we calculated the epipolar line on image B. </br>
Then we use feature matching, find the matched points from both images.</br>
</br>
# 3d coordinates construct
Using the viewing of image A as the base 3d coordinates, and calculate coordinates of the view point of image B, and contruct the feature points in the 3d coordinate system.</br>
![alt text](https://raw.githubusercontent.com/Mocdo/3D-Reconstruction/master/report_pic/3.1.JPG "3d feature")
![alt text](https://raw.githubusercontent.com/Mocdo/3D-Reconstruction/master/report_pic/3.2.JPG "3d feature")



# Construct Disparity map and Depth map
for each pixel on image A, calculate the "depth", the distance from view point to object, and construct a depth map.</br>
Disparity map will be used in the process of construct the depth map.</br>
![alt text](https://raw.githubusercontent.com/Mocdo/3D-Reconstruction/master/report_pic/4.JPG "disparity map")
