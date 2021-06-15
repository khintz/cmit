set_property(SOURCE cmit.i PROPERTY CPLUSPLUS ON)
set_property(SOURCE cmit.i PROPERTY SWIG_MODULE_NAME pycmit)
swig_add_library(pycmit
  TYPE SHARED
  LANGUAGE python
  OUTPUT_DIR ${CMAKE_BINARY_DIR}/python/${PYTHON_PROJECT}/cmit
  SOURCES cmit.i)

target_include_directories(pycmit
  PRIVATE
  ../include
  ${Python_INCLUDE_DIRS}
  )
set_property(TARGET pycmit PROPERTY SWIG_USE_TARGET_INCLUDE_DIRECTORIES ON)

# note: macOS is APPLE and also UNIX !
if(APPLE)
  set_target_properties(pycmit PROPERTIES
    SUFFIX ".so"
    INSTALL_RPATH "@loader_path;@loader_path/../../${PYTHON_PROJECT}/.libs"
    )
  set_property(TARGET pycmit APPEND PROPERTY
    LINK_FLAGS "-flat_namespace -undefined suppress"
    )
elseif(UNIX)
  set_target_properties(pycmit PROPERTIES
    INSTALL_RPATH "$ORIGIN:$ORIGIN/../../${PYTHON_PROJECT}/.libs"
    )
endif()
target_link_libraries(pycmit PRIVATE cmit)

# Variable PYTHON_LIBRARIES can contains keyword `optimized`
# which won't be interpreted inside a generator expression.
# i.e. we can't use: $<$<PLATFORM_ID:Windows>:${PYTHON_LIBRARIES}>
# see: https://cmake.org/cmake/help/git-stage/command/target_link_libraries.html#command:target_link_libraries
if(MSVC)
  target_link_libraries(pycmit PRIVATE ${Python_LIBRARIES})
endif()