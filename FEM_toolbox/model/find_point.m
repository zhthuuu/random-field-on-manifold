% find the index of the targeted point in the P list
function idx = find_point(P, target, lim)
  num = 1;
  while 1
     distance = sqrt((P(num,1)-target(1))^2 + ...
                     (P(num,2)-target(2))^2 + ...
                     (P(num,3)-target(3))^2);
     if distance < lim
         fprintf('target coordinate is (%.4f, %.4f, %.4f)\n', ...
                  [P(num,1), P(num,2), P(num,3)]);
         idx = num;
         return;
     end
     num = num + 1;
  end
  disp('cannot find the point');
end