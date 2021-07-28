
add_library(cmit "")

target_sources(cmit
  PRIVATE
    include/cmit.hpp
    src/cmit.cpp
    src/pressure.cpp)
target_include_directories(cmit
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
    /Users/hintz/anaconda3/envs/cmit/lib/python3.8/site-packages/numpy/core/include
    )
target_compile_features(cmit PUBLIC cxx_std_11)
set_target_properties(cmit PROPERTIES
  VERSION ${PROJECT_VERSION}
  PUBLIC_HEADER include/cmit.hpp)
add_library(${PROJECT_NAME}::cmit ALIAS cmit)

if(BUILD_TESTING)
  add_subdirectory(test)
endif()

# Install
include(GNUInstallDirs)
install(TARGETS cmit
  EXPORT ${PROJECT_NAME}Targets
  PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cmit
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  #RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  )