classdef ObjectSegmentation
    methods (Static)
        function res = threshold(image, threshold_algorithm, T_input)
            if (threshold_algorithm == "Selected Threshold")
                T = T_input/255;
                res = im2bw(image, T);
            elseif (threshold_algorithm == "Otsu")
                T =  graythresh(image);
                res = im2bw(image, T);
            elseif (threshold_algorithm == "Adaptive")
                res = imbinarize(image,'adaptive');
            end
        end

        function res = getSegmentationMask(image, threshold_algorithm, T_input)
            % converting image to binary
            bwimg = ObjectSegmentation.threshold(image, threshold_algorithm, T_input);
            
            % get segmentation mask
            res = imclearborder(bwimg);
            res = imclose(res, strel('disk',5));
            res = bwareaopen(res, 50);
            
            res = imfill(res, 4, 'holes');
            res = imclose(res, strel('disk',100));
        end

        function res = segmentObject(image, segmask, isGrayscale)
            if (isGrayscale)
                disp("ya");
                res(:,:) = image(:,:).*uint8(segmask);
            else
                res(:,:,1) = image(:,:,1).*uint8(segmask);
                res(:,:,2) = image(:,:,2).*uint8(segmask);
                res(:,:,3) = image(:,:,3).*uint8(segmask);
            end
        end
    end
end