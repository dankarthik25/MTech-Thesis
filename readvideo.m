% function img = readframe(vidObj,f)
str = 'ped_h4.AVI';
vidObj = VideoReader(str);
for f = 1:vidObj.NumberOfFrames 
img = read(vidObj,f);
imshow(img);
waitforbuttonpress;
end
