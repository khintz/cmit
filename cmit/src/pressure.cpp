#include <iostream>
#include <assert.h>
#include <math.h> 
#include <vector>
#include "cmit.hpp"

using namespace cmit;

// fvec cmit::netatmo_pressure_correction (fvec p0, fvec h) {
//     // Convert SLP reported by Netatmo to Surface pressure.
//     // Necessary because Netatmo uses a very crude formula.
//     const float T0 = 288.15;

//     const int s = sizeof(p0);

//     fvec ps(s,0);
//     double sum = 0.;

//     for(int i = 0; i < s; i++) {
//         ps[i] = p0[i] * pow( (1 - cmit::lapse_rate * h[i] / T0), 
//                          (cmit::gravit * cmit::M_dry / (cmit::R_ideal * cmit::lapse_rate)) );
//         sum+=ps[i];
//     }

//     return ps;
//     //return sum;
// }


double rms(double* seq, int n) {
    
    double rmse=0.;
    int i;

    for(i = 0; i< n; i++) {
        rmse+=seq[i];
    }

    return rmse;

}