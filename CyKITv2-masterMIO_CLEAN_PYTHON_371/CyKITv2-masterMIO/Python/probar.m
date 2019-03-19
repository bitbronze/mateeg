
clear classes
addpath_recurse();
CyKITv2 = py.importlib.import_module('eeg');

%iniciamos el EPOC+
py.CyKITv2.main();


% PLOTEO DE VALORES DEL GISORCOPIO
x = zeros(1,30000);
n = 1;


%el pintado es igual apra gyro y para sensores, sólo que cambia el baseline
while n <= 30000,
    
     b = cell2mat(cell(py.CyKITv2.get_data()));
     if b(2) == 32,          
         x(n) = abs(4.2 - ( (4201.02564096001 - b(7) ) * .128));
         plot(x(1:n));
         drawnow;
         n = n + 1;
     end
     
end
% el 7 es el eje x
% el 8 es el eje y



% PLOTEO DE VALORES DE LOS SENSORES
% baseline = 4201.0256409600;
% 
% while n <= 30000,
%     
%      b = cell2mat(cell(py.CyKITv2.get_data()));
%      if b(2) == 16,                      
%          x(n) = abs(floor(baseline/1000)- ( (baseline - b(4) ) * .128));
%          plot(x(1:n));
%          drawnow;
%          baseline = (baseline + b(4) + 4201.02564096001)/3; 
%          n = n + 1;
%      end
%      
% end

% AF3 --> b(3)

% 
% realizar funcion que actualice los baselines para los sensores
% 
%  if (init_baseline == false) {
%          baseline[select_contact] = (baseline[select_contact] + parseFloat(contact[select_contact]) + 4201.02564096001)/3;
%  }
%  else{
%          baseline[select_contact] = abs(parseFloat(contact[select_contact]));
%  }



