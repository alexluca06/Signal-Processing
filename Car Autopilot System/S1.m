%% S1 - autopilot car system:
 % in: (current_speed, error) -> out: (current speed + gain)

function out=S1(current_speed, error)
    out = current_speed;

    if(error > 10)

        out = current_speed + 5;

    elseif(error > 0)

        out = current_speed + 1;

    elseif(error == 0)

        out = current_speed;

    end
end
   
    

