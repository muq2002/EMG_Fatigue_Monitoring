function out = calculate_zc(signal)
    out = sum(diff(sign(signal)) ~= 0);
end