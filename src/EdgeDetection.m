classdef EdgeDetection
    methods (Static)
        function laplaceEdge = edgeDetectionLaplace(image)
            % Mask konvolusi laplace
            % H = [0 1 0; 1 -4 1; 0 1 0];
            H =  [1 1 1; 1 -8 1;1 1 1];

            % Konvolusi dan uji nilai ambang
            laplaceEdge = uint8(convn(double(image), double(H),"same"));
        end

        function prewittEdge = edgeDetectionPrewitt(image)
            % Mask konvolusi Prewitt
            Px = [-1 0 1; -1 0 1; -1 0 1];
            Py = [-1 -1 -1; 0 0 0; 1 1 1];
            Jx = convn(double(image), double(Px), 'same');
            Jy =  convn(double(image), double(Py), 'same');
            % Menghitung kekuatan tepi
            Jedge = sqrt(Jx.^2 + Jy.^2);

            prewittEdge = uint8(Jedge);
        end

        function robertsEdge = edgeDetectionRoberts(image)
            % Mask konvolusi Roberts
            Rx = [1 0; 0 -1];
            Ry = [0 1; -1 0];
            Jx = convn(double(image), double(Rx), 'same');
            Jy =  convn(double(image), double(Ry), 'same');
            % Menghitung kekuatan tepi
            Jedge = sqrt(Jx.^2 + Jy.^2);

            robertsEdge = uint8(Jedge);
        end

        function cannyEdge = edgeDetectionCanny(image)
            % Mengonversi image berwarna ke grayscale
            if (~Helper.isGrayscale(image))
                image = rgb2gray(image);
            end

            % Menggunakan fungsi built-in
            cannyEdge = im2uint8(edge(image, 'Canny'));
        end

        function res = edgeDetection(image, algorithm)
            switch algorithm
                case "Laplace"
                    res = EdgeDetection.edgeDetectionLaplace(image);
                case "LoG"
                case "Sobel"
                case "Prewitt"
                    res = EdgeDetection.edgeDetectionPrewitt(image);
                case "Roberts"
                    res = EdgeDetection.edgeDetectionRoberts(image);
                case "Canny"
                    res = EdgeDetection.edgeDetectionCanny(image);
            end
        end
    end
end