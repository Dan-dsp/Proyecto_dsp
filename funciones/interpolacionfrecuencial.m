function [y] = interpolacionfrecuencial(f1,signal,fn) 
            oldfreq=0:(1/f1):(length(signal)-1)/f1;
            newfreq =0:(1/fn):(length(signal)-1)/fn;
            y=interp1(oldfreq,signal,newfreq)';
        end