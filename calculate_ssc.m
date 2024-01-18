function out = calculate_ssc(signal)
    result = 0;
    for number = 2:length(signal) - 1 
        old_sample = signal(number - 1);
        current_sample = signal(number);
        new_sample = signal(number + 1);
        
        
        if (current_sample > old_sample  && current_sample > new_sample) || ... 
                (current_sample < old_sample  && current_sample < new_sample) 
            result = result + 1;
        end
    end
    out = result;
end