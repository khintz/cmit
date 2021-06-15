%module cmit

  %{
      /* Includes the header in the wrapper code */
      #include "cmit.hpp"
  %}

  /* Parse the heade file to generate wrappers */
  %include "cmit.hpp"