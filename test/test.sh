#!/bin/bash

set -x

cd ../build/python/build/lib/cmakeswig/cmit/

PY=/home/kah/miniconda3/envs/py37/bin/python

#$PY -c "import numpy as np; import pycmit; a=pycmit.add(5,5); print(a); a=np.array([5.0],dtype=np.double); b=np.array([4.0],dtype=np.double); c=pycmit.netatmo_pressure_correction(a,b)"


$PY -c "import numpy as np; import pycmit; a=pycmit.add(5,5); print(a); a=np.array([5.0],dtype=np.double); b=np.array([4.0, 5.0],dtype=np.double); c=pycmit.rms(a,4)"


