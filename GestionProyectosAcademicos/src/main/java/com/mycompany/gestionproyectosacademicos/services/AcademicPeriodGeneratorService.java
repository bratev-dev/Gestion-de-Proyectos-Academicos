package com.mycompany.gestionproyectosacademicos.services;

import com.mycompany.gestionproyectosacademicos.filter.IFilter;
import com.mycompany.gestionproyectosacademicos.entities.Project;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

public class AcademicPeriodGeneratorService{
    public List<String> generateAcademicPeriods() {
        List<String> periods = new ArrayList<>();
        Calendar calendar = Calendar.getInstance();
        int añoActual = calendar.get(Calendar.YEAR);
        int mesActual = calendar.get(Calendar.MONTH) + 1;

        for (int año = 2000; año <= añoActual; año++) {
            periods.add(año + "-1");
            periods.add(año + "-2");
        }

        if (mesActual >= 7) {
            periods.add(añoActual + "-2");
        }

        Collections.sort(periods, Collections.reverseOrder());
        return periods;
    }
}
