function statsInfo = analyzeCluster(lb,center)
% function statsInfo = statsFunc(lb,center)

   whiteCount = zeros(1, size(center, 1));
   for k = 1 : size(center, 2)
       for i = 1 : size(lb, 1)
           for j = 1 : size(lb, 2)
               if (lb(i, j) == k)
                   whiteCount(k) = whiteCount(k) + 1;
               end
           end
       end
   end
   [~, index] = min(whiteCount);
   areaFraction = whiteCount(index) / (size(lb(index), 1) * size(lb(index), 2));
   statsInfo = areaFraction;
       
       


return