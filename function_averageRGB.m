function F=averageRGB(img)

%%Returns F as a vector with 3 values [0:1]

red=img(:,:,1);
red=reshape(red,1,[]);
average_red=mean(red);

%sum RGB from each cell to form a vector
green=img(:,:,2);
green=reshape(green,1,[]);
average_green=mean(green);

blue=img(:,:,1);
blue=reshape(blue,1,[]);
average_blue=mean(blue);


F=[average_red average_green average_blue]; 


return;