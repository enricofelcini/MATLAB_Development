% Musical notation test: Classical vs Modern
clc, clear all

str = 'y';

while str == 'y'

    t = randi([1 7],1);
    answer = false;
    switch t
        case 1
            sc = {'do'};
            sm = {'C'};
        case 2
            sc = {'re'};
            sm = {'D'};
        case 3
            sc = {'mi'};
            sm = {'E'};
        case 4
            sc = {'fa'};
            sm = {'F'};
        case 5
            sc = {'sol'};
            sm = {'G'};
        case 6
            sc = {'la'};
            sm = {'A'};
        case 7
            sc = {'si'};
            sm = {'B'};

    end
    while answer == false
        strIN=input(['Which note corresponds to ',sm{1}, '? '], 's');
        if strIN == sc{1}
            disp('CORRECT!')
            answer = true;
        else
            disp('Try again!')
        end
    end

    str = input('Do you want to continue? [y/n]', 's');
    if isempty(str)
        str = 'y';
    end
    
end


