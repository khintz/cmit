#ifndef CMIT_H
#define CMIT_H
#include <stdio.h>
#include <iostream>
#include <vector>

#define CMIT_VERSION "0.1"
#define __version__ CMIT_VERSION

namespace cmit {

    // typedef std::vector<int> ivec;
    // typedef std::vector<float> fvec;
    // typedef std::vector<double> dvec;

    /** Mathematical constant pi */
    static const float pi = 3.14159265;
    /** Atmospheric Lapse Rate (K/m) */
    static const float lapse_rate = 0.0065;
    /** Gravitational acceleration (m/s**2) */
    static const float gravit = 9.82;
    /** Specific heat at constant pressure (J/(kg*K)) */
    static const float cp = 1007.0;
    /** Molar mass of dry air (kg/mol) */
    static const float M_dry = 0.0289644;
    /** Ideal gas constant (J/(mol*K)) */
    static const float R_ideal = 8.31447;

    int add (int a, int b);

    /** ****************************************
     * @name Netatmo Pressure Correction
     * Correct wrong conversion to sea level done by Netatmo
     * *****************************************/ /**@{*/
    /** Netatmo Pressure Correction
     *  @param p0 Mean Sea Level Pressure [hPa]
     *  @param h Height above sea level [m]
     *  @return Surface Pressure [hPa]
     */
    // fvec netatmo_pressure_correction (fvec p0, fvec h);

    double rms (double* seq, int n);

}

#endif