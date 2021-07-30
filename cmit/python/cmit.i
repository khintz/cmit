%module cmit
%{
  #define SWIG_FILE_WITH_INIT
  #include "cmit.hpp"
%}

%include "numpy.i"

%init %{
  import_array();
%}

%apply (double* IN_ARRAY1, int DIM1) {(double* seq, int n)};

%include "cmit.hpp"




// %module cmit

// // #if defined(SWIGPYTHON)
// //     import_array();
// // #endif

// %include "numpy.i"


// import_array();


// %include "vector.i"
// %apply std::vector<int>& OUTPUT { std::vector<int>& flags };
// %apply std::vector<float>& OUTPUT { std::vector<float>& prob_gross_error };
// %apply std::vector<float>& OUTPUT { std::vector<float>& rep };
// %apply std::vector<float>& OUTPUT { std::vector<float>& ps };
// %apply std::vector<float>& OUTPUT { std::vector<float>& p0 };
// %apply std::vector<float>& OUTPUT { std::vector<float>& h };
// %apply std::vector<int>& OUTPUT { std::vector<int>& boxids };
// %apply std::vector<float>& OUTPUT { std::vector<float>& x_coords };
// %apply std::vector<float>& OUTPUT { std::vector<float>& y_coords };
// %apply std::vector<float>& OUTPUT { std::vector<float>& z_coords };
// %apply std::vector<float>& OUTPUT { std::vector<float>& distances };
// %apply std::vector<std::vector<float> >& OUTPUT { std::vector<std::vector<float> >& distances };
// %apply std::vector<float>& OUTPUT { std::vector<float>& scores };
// %apply std::vector<float>& OUTPUT { std::vector<float>& num_inner };
// %apply std::vector<float>& OUTPUT { std::vector<float>& horizontal_scale };
// %apply int& OUTPUT { int& X1_out };
// %apply int& OUTPUT { int& Y1_out };
// %apply int& OUTPUT { int& X2_out };
// %apply int& OUTPUT { int& Y2_out };

// %init %{
// import_array();
// %}

//   %{
//       /* Includes the header in the wrapper code */
//       #include "cmit.hpp"
//   %}

//   /* Parse the heade file to generate wrappers */
//   %include "cmit.hpp"