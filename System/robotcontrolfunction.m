function [] = robotcontrolfunction( directioncommand )

persistent myev3 rightmotor leftmotor
    if isempty(myev3)
        myev3 = legoev3('usb');
        rightmotor = motor(myev3,'C');
        leftmotor = motor(myev3,'B');
    end

    
if strcmp(directioncommand, 'null')
    start(rightmotor,0);
    start(leftmotor,0);
    
elseif strcmp(directioncommand, 'right')
    start(rightmotor,20);
    start(leftmotor,-20);
    
elseif strcmp(directioncommand, 'left')
    start(rightmotor,-20);
    start(leftmotor,20);
    
elseif strcmp(directioncommand, 'forwards')
    start(rightmotor,20);
    start(leftmotor,20);

elseif strcmp(directioncommand, 'end')
    stop(rightmotor);
    stop(leftmotor);

end

end

