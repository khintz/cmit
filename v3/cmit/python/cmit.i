// -*- c++ -*-

%module cmit

%{
#define SWIG_FILE_WITH_INIT
#include "cmit.hpp"
%}

// Get the NumPy typemaps
%include "numpy.i"

 // Get the STL typemaps
%include "stl.i"

// Handle standard exceptions
%include "exception.i"
%exception
{
  try
  {
    $action
  }
  catch (const std::invalid_argument& e)
  {
    SWIG_exception(SWIG_ValueError, e.what());
  }
  catch (const std::out_of_range& e)
  {
    SWIG_exception(SWIG_IndexError, e.what());
  }
}
%init %{
  import_array();
%}

// Global ignores
%ignore *::operator=;
%ignore *::operator[];

%define %apply_numpy_typemaps(TYPE)

%apply (TYPE IN_ARRAY1[ANY]) {(TYPE vector[3])};
%apply (TYPE* IN_ARRAY1, int DIM1) {(TYPE* series, int size)};
%apply (int DIM1, TYPE* IN_ARRAY1) {(int size, TYPE* series)};

%apply (TYPE INPLACE_ARRAY1[ANY]) {(TYPE array[3])};
%apply (TYPE* INPLACE_ARRAY1, int DIM1) {(TYPE* array, int size)};
%apply (int DIM1, TYPE* INPLACE_ARRAY1) {(int size, TYPE* array)};

%apply (TYPE ARGOUT_ARRAY1[ANY]) {(TYPE even[3])};
%apply (TYPE ARGOUT_ARRAY1[ANY]) {(TYPE odd[ 3])};
%apply (TYPE* ARGOUT_ARRAY1, int DIM1) {(TYPE* twoVec, int size)};
%apply (int DIM1, TYPE* ARGOUT_ARRAY1) {(int size, TYPE* threeVec)};

%enddef    /* %apply_numpy_typemaps() macro */

%apply_numpy_typemaps(signed char       )
%apply_numpy_typemaps(unsigned char     )
%apply_numpy_typemaps(short             )
%apply_numpy_typemaps(unsigned short    )
%apply_numpy_typemaps(int               )
%apply_numpy_typemaps(unsigned int      )
%apply_numpy_typemaps(long              )
%apply_numpy_typemaps(unsigned long     )
%apply_numpy_typemaps(long long         )
%apply_numpy_typemaps(unsigned long long)
%apply_numpy_typemaps(float             )
%apply_numpy_typemaps(double            )

// Apply the 1D NumPy typemaps
%apply (int DIM1  , long* INPLACE_ARRAY1)
      {(int length, long* data          )};
%apply (long** ARGOUTVIEW_ARRAY1, int* DIM1  )
      {(long** data             , int* length)};

%include "cmit.hpp"

%extend Array1
{
  void __setitem__(int i, long v)
  {
    self->operator[](i) = v;
  }

  long __getitem__(int i)
  {
    return self->operator[](i);
  }

  int __len__()
  {
    return self->length();
  }

  std::string __str__()
  {
    return self->asString();
  }
}
