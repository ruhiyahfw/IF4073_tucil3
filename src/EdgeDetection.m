classdef EdgeDetection
    methods (Static)
        function laplaceEdge = edgeDetectionLaplace(image)
            % Mask konvolusi laplace
            % H = [0 1 0; 1 -4 1; 0 1 0];
            H =  [1 1 1; 1 -8 1;1 1 1];

            % Konvolusi dan uji nilai ambang
            laplaceEdge = uint8(convn(double(image), double(H)));
        end

        function res = edgeDetection(image, algorithm)
            switch algorithm
                case "Laplace"
                    res = EdgeDetection.edgeDetectionLaplace(image);
                case "LoG"
                case "Sobel"
                case "Prewitt"
                case "Roberts"
                case "Canny"
            end
        end
    end
end