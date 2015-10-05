

count = 100;
for i = 1:count
    for j = 1:10
        x = rand(10,1);
        y = rand(10,1);
        c1 = rand();
        c2 = rand();
        c3 = rand();
        if( mod(j,2) == 0)
            color = 'red';
        else
            color = 'green';
        end
        
    end
    hold on;
    
    scatter(x, y,10, [c1 c2 c3]);
    
end