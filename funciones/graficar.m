function graficar(axes, specific_title, signal)
    number_of_points = (1:length(signal));
    stem(axes, number_of_points, signal);
    title(axes, specific_title);
    xlabel(axes, 'n');
    grid(axes, 'on');
end
