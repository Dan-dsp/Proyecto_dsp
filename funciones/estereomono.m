function [prosig,prosigFs] = estereomono(Fs1,Fs2,signal1,signal2,axes)
if Fs2<Fs1
                nf = freqint(Fs1,signal1,Fs2); %señal cambjada
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
                prosig = signal2*0.5 + newfreq*0.5; 
            else
                nf = freqint(app,Fs2,signal2,Fs1); %señal cambjada
                newfreq = transpose(nf);
                lnf = length(newfreq);
                lns1 = length(signal1);
                prosigFs = Fs1
                if lnf>lns1
                    lnss = lnf-lns1;
                    signal1 = [signal1 zeros(1,lnss)];
                    
                else
                     lnss = lns1-lnf;
                    newfreq = [newfreq zeros(1,lnss)];
                    
                end
             
                prosig = signal1*0.5 + newfreq*0.5;
            end
          disp(size(prosig))
            plot(axes,prosig)
            
end