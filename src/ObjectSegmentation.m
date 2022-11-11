classdef ObjectSegmentation
    methods (Static)
        function res = threshold(image, threshold_algorithm, T_input)
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
            %res = imclose(res, strel('disk',5));
            %res = imclearborder(bwimg);
            %res = bwareaopen(res, 50);
            
            %res = imfill(res, 4, 'holes');
            %res = imclose(res, strel('disk',100));
            
            res = imclearborder(bwimg);
            res = imclose(res, strel('line', 10,0));
            res = imfill(res, 'holes');
            res = imopen(res, strel(ones(3,3)));
            res = bwareaopen(res, 1500);
        end

        function res = segmentObject(image, segmask, isGrayscale)
            if (isGrayscale)
                res(:,:) = image(:,:).*uint8(segmask);
            else
                res(:,:,1) = image(:,:,1).*uint8(segmask);
                res(:,:,2) = image(:,:,2).*uint8(segmask);
                res(:,:,3) = image(:,:,3).*uint8(segmask);
            end
        end
    end
end