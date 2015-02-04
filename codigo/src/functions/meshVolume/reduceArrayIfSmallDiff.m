function [ reduced ] = reduceArrayIfSmallDiff( array, d )
    %array = zeros(size(array));
    len = max(size(array));
    if (len == 1)
        display('Uno????');
        display(array);
        reduced = [];
        return;
    end
    for i=1:len
        if (len == i+1) break; end
        diff = array(i+1) - array(i);
        if (diff < d)
            array(i) = array(i+1);
        end
    end
    reduced = unique(array);
end

