package com.mycompany.gestionproyectosacademicos.observer;

import com.mycompany.gestionproyectosacademicos.observer.IObserver;
import java.util.ArrayList;

public abstract class Subject {
    ArrayList<IObserver> observers;

    public void Subject() {

    }

    /**
     * Agrega un observador
     *
     * @param obs
     */
    public void addObserver(IObserver obs) {
        if (observers == null) {
            observers = new ArrayList<>();
        }
        observers.add(obs);
    }

    /**
     * Notifica a todos los observadores que hubo un cambio en el modelo
     */
    public void notifyAllObserves() {
        for (IObserver each : observers) {
            each.update(this);
        }
    }
}
