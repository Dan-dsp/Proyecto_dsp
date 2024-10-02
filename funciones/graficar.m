function graficar(axes, title, signal, number_of_points)
    stem(axes, number_of_points, signal);
    title(axes, title);
    xlabel(axes, 'n');
    grid(axes, 'on');
end
