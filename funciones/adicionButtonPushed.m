function [prosig,prosigFs] = adicionButtonPushed(Fs1,Fs2,signal1,signal2)

%%%% Se deben obtener los valores de la señal seleccionada

    
            if Fs2<Fs1
                nf = interpolacionfrecuencial(Fs1,signal1,Fs2); %señal cambiada
                newfreq = transpose(nf);
                lnf = length(newfreq);
                lns2 = length(signal2);
                prosigFs = Fs2;
                if lnf>lns2
                    lnss = lnf-lns2;
                    signal2 = [signal2 zeros(1,lnss)];
                    
                else
                     lnss = lns2-lnf;
                    newfreq = [newfreq zeros(1,lnss)];
                    
                end
                prosig = signal2 + newfreq; 
            else
                nf = interpolacionfrecuencial(Fs2,signal2,Fs1); %señal cambiada
                newfreq = transpose(nf);
                lnf = length(newfreq);
                lns1 = length(signal1);
                prosigFs = Fs1;
                if lnf>lns1
                    lnss = lnf-lns1;
                    signal1 = [signal1 zeros(1,lnss)];
                    
                else
                     lnss = lns1-lnf;
                    newfreq = [newfreq zeros(1,lnss)];
                    
                end
             
                prosig = signal1 + newfreq;
            end
          disp(size(prosig))


  end