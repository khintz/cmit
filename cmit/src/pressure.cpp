#include <iostream>
#include <assert.h>
#include <math.h> 
#include "cmit.hpp"

using namespace cmit;

double cmit::netatmo_pressure_correction (double* p0, double* h) {
    // Convert SLP reported by Netatmo to Surface pressure.
    // Necessary because Netatmo uses a very crude formula.
    const float T0 = 288.15;

    const int s = sizeof(p0);

    //double *ps(s,0);
    //std::vector<double> ps (s); 
    fvec ps(s,0);
    double sum = 0.;

    for(int i = 0; i < s; i++) {
        ps[i] = p0[i] * pow( (1 - cmit::lapse_rate * h[i] / T0), 
                         (cmit::gravit * cmit::M_dry / (cmit::R_ideal * cmit::lapse_rate)) );
        sum+=ps[i];
    }

    //return ps;
    return sum;
}


double cmit::sum_array(double* input_array, int length) {

  /* Initialize sum */
  double sum = 0.;

  /* Compute sum of array elements */
  for (int i=0; i < length; i++)
    sum += input_array[i];

  return sum;
}