if(NOT BUILD_PYTHON)
  return()
endif()

# Use latest UseSWIG module
cmake_minimum_required(VERSION 3.14)

if(NOT TARGET CMakeSwig::cmit)
  message(FATAL_ERROR "Python: missing cmit TARGET")
endif()

# Will need swig
set(CMAKE_SWIG_FLAGS)
find_package(SWIG REQUIRED)
include(UseSWIG)

if(UNIX AND NOT APPLE)
  list(APPEND CMAKE_SWIG_FLAGS "-DSWIGWORDSIZE64")
endif()

# Find Python
find_package(Python REQUIRED COMPONENTS Interpreter Development)

if(Python_VERSION VERSION_GREATER_EQUAL 3)
  list(APPEND CMAKE_SWIG_FLAGS "-py3;-DPY3")
endif()

# Needed by python/CMakeLists.txt
set(PYTHON_PROJECT cmakeswig)

# Swig wrap all libraries
foreach(SUBPROJECT IN ITEMS cmit)
  add_subdirectory(${SUBPROJECT}/python)
endforeach()

#######################
## Python Packaging  ##
#######################
# Find if python module MODULE_NAME is available,
# if not install it to the Python user install directory.
function(search_python_module MODULE_NAME)
  execute_process(
    COMMAND ${Python_EXECUTABLE} -c "import ${MODULE_NAME}; print(${MODULE_NAME}.__version__)"
    RESULT_VARIABLE _RESULT
    OUTPUT_VARIABLE MODULE_VERSION
    ERROR_QUIET
    OUTPUT_STRIP_TRAILING_WHITESPACE
    )
  if(${_RESULT} STREQUAL "0")
    message(STATUS "Found python module: ${MODULE_NAME} (found version \"${MODULE_VERSION}\")")
  else()
    message(WARNING "Can't find python module \"${MODULE_NAME}\", user install it using pip...")
    execute_process(
      COMMAND ${Python_EXECUTABLE} -m pip install --upgrade --user ${MODULE_NAME}
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )
  endif()
endfunction()

# Look for required python modules
search_python_module(setuptools)
search_python_module(wheel)
search_python_module(numpy)

# setup.py.in contains cmake variable e.g. @PYTHON_PROJECT@ and
# generator expression e.g. $<TARGET_FILE_NAME:pycmit>
configure_file(
  ${PROJECT_SOURCE_DIR}/python/setup.py.in
  ${PROJECT_BINARY_DIR}/python/setup.py.in
  @ONLY)
file(GENERATE
  OUTPUT ${PROJECT_BINARY_DIR}/python/$<CONFIG>/setup.py
  INPUT ${PROJECT_BINARY_DIR}/python/setup.py.in)

add_custom_command(
  OUTPUT python/setup.py
  DEPENDS ${PROJECT_BINARY_DIR}/python/$<CONFIG>/setup.py
  COMMAND ${CMAKE_COMMAND} -E copy ./$<CONFIG>/setup.py setup.py
  WORKING_DIRECTORY python)

add_custom_command(
  OUTPUT python/${PYTHON_PROJECT}/__init__.py
  DEPENDS ${PROJECT_SOURCE_DIR}/python/__init__.py.in
  COMMAND ${CMAKE_COMMAND} -E copy
    ${PROJECT_SOURCE_DIR}/python/__init__.py.in
    ${PYTHON_PROJECT}/__init__.py
  WORKING_DIRECTORY python)

add_custom_command(
  OUTPUT python/${PYTHON_PROJECT}/cmit/__init__.py
  DEPENDS ${PROJECT_SOURCE_DIR}/python/__init__.py.in
  COMMAND ${CMAKE_COMMAND} -E copy
    ${PROJECT_SOURCE_DIR}/python/__init__.py.in
    ${PYTHON_PROJECT}/cmit/__init__.py
  WORKING_DIRECTORY python)


add_custom_target(python_package ALL
  DEPENDS
    python/setup.py
    python/${PYTHON_PROJECT}/__init__.py
    python/${PYTHON_PROJECT}/cmit/__init__.py
  # COMMAND ${CMAKE_COMMAND} -E remove_directory dist
  COMMAND ${CMAKE_COMMAND} -E make_directory ${PYTHON_PROJECT}/.libs
  COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:pycmit> ${PYTHON_PROJECT}/cmit

  # Don't need to copy static lib on Windows
  COMMAND ${CMAKE_COMMAND} -E $<IF:$<BOOL:${UNIX}>,copy,true>
    $<TARGET_FILE:cmit> ${PYTHON_PROJECT}/.libs
  COMMAND ${Python_EXECUTABLE} setup.py bdist_wheel
  BYPRODUCTS
    python/${PYTHON_PROJECT}
    python/build
    python/dist
    python/${PYTHON_PROJECT}.egg-info
  WORKING_DIRECTORY python)