function We = rweber (P_fluidos,fluido)
for caso_ = 1:height(P_fluidos)
    if   strcat(P_fluidos.Fluido{caso_},num2str(P_fluidos.Altura(caso_)))  == fluido
      break
    end
end
We = P_fluidos.We(caso_);
end