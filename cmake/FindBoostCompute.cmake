if(NOT BoostCompute_INCLUDE_DIRS)
  find_path(BoostCompute_INCLUDE_DIRS
    NAMES "boost/compute.hpp"
    PATHS "${BoostCompute_DIR}/include"
  )
endif()

if(NOT BoostCompute_INCLUDE_DIRS)
  find_path(BoostCompute_INCLUDE_DIRS
    NAMES "boost/compute.hpp"
    PATHS "${BOOST_ROOT}"
  )
endif()

if(BoostCompute_INCLUDE_DIRS)
  set(BoostCompute_FOUND TRUE)
  message("Found Boost Compute standalone library. ${BoostCompute_INCLUDE_DIRS}")
else()
  message(FATAL_ERROR "Cannot find Boost Compute standalone library!")
endif()

mark_as_advanced(BoostCompute_INCLUDE_DIRS BoostCompute_FOUND)

find_package(Boost REQUIRED COMPONENTS system)
find_package(OpenCL REQUIRED)

# if(NOT TARGET BoostCompute::BoostCompute)
  add_library(BoostCompute::BoostCompute INTERFACE IMPORTED)
  set_property(TARGET BoostCompute::BoostCompute APPEND PROPERTY
    INTERFACE_INCLUDE_DIRECTORIES
      "${BoostCompute_INCLUDE_DIRS}"
  )
  set_property(TARGET BoostCompute::BoostCompute APPEND PROPERTY
    INTERFACE_LINK_LIBRARIES
      OpenCL::OpenCL
      Boost::boost
      Boost::system
      Boost::disable_autolinking
      Boost::dynamic_linking
  )
  set_property(TARGET BoostCompute::BoostCompute APPEND PROPERTY
    INTERFACE_COMPILE_DEFINITIONS
      BOOST_COMPUTE_HAVE_THREAD_LOCAL # thread-safe
      BOOST_COMPUTE_THREAD_SAFE       # thread-safe
      BOOST_COMPUTE_NO_BOOST_CHRONO   # do not use boost chrono
      $<$<CONFIG:Debug>:BOOST_COMPUTE_DEBUG_KERNEL_COMPILATION>
  )
# endif()
