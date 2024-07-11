function knapsack_solver()
    % Solicitar al usuario ingresar los datos
    prompt = 'Ingrese el número de elementos: ';
    n = input(prompt);
    
    weights = zeros(1, n);
    values = zeros(1, n);
    
    fprintf('Ingrese los pesos de los %d elementos:\n', n);
    for i = 1:n
        prompt = sprintf('Peso del elemento %d: ', i);
        weights(i) = input(prompt);
    end
    
    fprintf('Ingrese los valores de los %d elementos:\n', n);
    for i = 1:n
        prompt = sprintf('Valor del elemento %d: ', i);
        values(i) = input(prompt);
    end
    
    prompt = 'Ingrese la capacidad máxima de la mochila: ';
    capacity = input(prompt);
    
    % Llamar a la función para resolver el problema de la mochila
    [max_value, chosen_items] = solve_knapsack(weights, values, capacity, n);
    
    % Mostrar los resultados
    fprintf('Valor máximo en la mochila: %d\n', max_value);
    fprintf('Elementos seleccionados (1 indica seleccionado, 0 indica no seleccionado):\n');
    disp(chosen_items);
end

function [max_value, chosen_items] = solve_knapsack(weights, values, capacity, n)
    % Inicialización de la matriz para almacenar los valores óptimos
    dp = zeros(n+1, capacity+1);
    
    % Llenar la matriz dp utilizando programación dinámica
    for i = 1:n
        for w = 1:capacity
            if weights(i) <= w
                dp(i+1, w+1) = max(dp(i, w+1), dp(i, w+1-weights(i)) + values(i));
            else
                dp(i+1, w+1) = dp(i, w+1);
            end
        end
    end
    
    % El valor máximo encontrado en la mochila
    max_value = dp(n+1, capacity+1);
    
    % Recuperar los índices de los elementos seleccionados
    chosen_items = false(1, n);
    total_weight = 0;
    for i = n:-1:1
        if dp(i+1, capacity+1) ~= dp(i, capacity+1)
            chosen_items(i) = true;
            capacity = capacity - weights(i);
            total_weight = total_weight + weights(i);
        end
    end
end
