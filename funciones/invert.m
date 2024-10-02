function [prosig,prosigFs] = invert(dataSignal,Fsin,axes)
            prosig = fliplr(dataSignal);
            prosigFs = Fsin;
            plot(axes,prosig)
end