function [prosig,prosigFs] = Ajustevolumen(datain,Fsin,potenciometro,modo,axes)
volume = potenciometro/100;
             
             
             if modo == 'Amplitud constante'
                 prosig = datain*volume;
             else
                 if modo == 'Amplitud linealmente creciente'
                    sizz = length(datain);
                    volm = linspace(0,volume,sizz);
                    prosig = datain .* volm;
                 elseif modo == 'Amplitud linealmente decreciente'
                     sizz = length(datain);
                    volm = linspace(volume,0,sizz);
                    prosig = datain .* volm;
                 end
             end
             
             prosigFs = Fsin;
             plot(axes,prosig)
end