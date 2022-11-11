classdef ObjectSegmentation
    methods (Static)
        function res = threshold(image, threshold_algorithm, T_input)
            % function to converting image to binary
            % based on threshold algorithm selected
            if (threshold_algorithm == "Selected Threshold")
                T = T_input/255;
                res = imbinarize(image, T);
            elseif (threshold_algorithm == "Otsu")
                T =  graythresh(image);
                res = imbinarize(image, T);
            elseif (threshold_algorithm == "Adaptive")
                res = imbinarize(image,'adaptive');
            end
        end

        function res = getSegmentationMask(image, threshold_algorithm, T_input)
            % converting image to binary
            bwimg = ObjectSegmentation.threshold(image, threshold_algorithm, T_input);
            
            % get segmentation mask
            % clean up the pixels on the edges of the image
            res = imclearborder(bwimg);
            % corphologically closing image so that adjacent edges can be connected
            res = imclose(res, strel('line', 10,0));
            % fill in the areas surrounded by connected edges
            res = imfill(res, 'holes');
            % morphologically open image
            res = imopen(res, strel(ones(3,3)));
            % remove under threshold filled area 
            res = bwareaopen(res, 1500);
        end

        function res = segmentObject(image, segmask, isGrayscale)
            if (isGrayscale)
                % if image is grayscale
                res(:,:) = image(:,:).*uint8(segmask);
            else
                % if image is RGB (has 3 channels)
                res(:,:,1) = image(:,:,1).*uint8(segmask);
                res(:,:,2) = image(:,:,2).*uint8(segmask);
                res(:,:,3) = image(:,:,3).*uint8(segmask);
            end
        end
    end
end