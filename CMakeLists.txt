cmake_minimum_required(VERSION 2.8.0)

project(ssba)

string(TOLOWER ${PROJECT_NAME} PROJECT_NAME_LOWER)
set (PACKAGE_MAJOR_VERSION 4)
set (PACKAGE_MINOR_VERSION 0)
set (${PROJECT_NAME}_MAJOR_VERSION ${PACKAGE_MAJOR_VERSION})
set (${PROJECT_NAME}_MINOR_VERSION ${PACKAGE_MINOR_VERSION})
set (PACKAGE_VERSION ${PACKAGE_MAJOR_VERSION}.${PACKAGE_MINOR_VERSION})
set (${PROJECT_NAME}_VERSION ${PACKAGE_VERSION})

#####################################################################
if (DEFINED PACKAGE_PATH)
  set (PACKAGE_PATH ${PACKAGE_PATH} CACHE PATH "Package directory" FORCE)
  set (CMAKE_PREFIX_PATH ${PACKAGE_PATH} ${CMAKE_PREFIX_PATH})
  message (STATUS "CMAKE_PREFIX_PATH set to ${CMAKE_PREFIX_PATH}")
elseif (WIN32)
  # If you need to support the traditional cmake mechanisms, omit this check.
  #message (FATAL_ERROR
  #  "You MUST set PACKAGE_PATH, e.g. cmake -D PACKAGE_PATH=C:/pkg")
endif ()

if (NOT DEFINED INSTALL_PATH AND DEFINED PACKAGE_PATH)
  list (GET PACKAGE_PATH 0 TEMP_IPATH)
  if (NOT WIN32)
    set (INSTALL_PATH ${TEMP_IPATH} CACHE PATH "Install Directory" FORCE)
  else ()
    set (INSTALL_PATH ${TEMP_IPATH}/${PROJECT_NAME}-${PACKAGE_VERSION}
    CACHE PATH "Install Directory" FORCE)
  endif ()
endif ()
if (DEFINED INSTALL_PATH)
  set (INSTALL_PATH ${INSTALL_PATH} CACHE PATH "Install Directory" FORCE)
  set (CMAKE_INSTALL_PREFIX ${INSTALL_PATH})
endif ()
message (STATUS "CMAKE_INSTALL_PREFIX set to ${CMAKE_INSTALL_PREFIX}")


#####################################################################
# set release optimization flags & debug postfix & build type
if (WIN32)
	if (CMAKE_SIZEOF_VOID_P EQUAL 8)
		# if 64 bit build then do not set SSE2 flag
		# all 64bit architectures have SSE2 so it's enabled by default and the
		# compiler ignores and complains about this flag 
		set(CMAKE_CXX_FLAGS_RELEASE 
			"${CMAKE_CXX_FLAGS_RELEASE} /Ox /Ob2 /Oi /Ot")
	else ()
		set(CMAKE_CXX_FLAGS_RELEASE 
			"${CMAKE_CXX_FLAGS_RELEASE} /Ox /Ob2 /Oi /Ot /arch:SSE2")
	endif()
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP")
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /MP")	
else()
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O2")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -std=c++11")
    if (DEFINED CUSTOM_ARCH)
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=${CUSTOM_ARCH}")
    endif()
endif()

# debug postfix
set (CMAKE_DEBUG_POSTFIX _d CACHE STRING "debug postfix" FORCE)

# set include base directory
set (INCLUDE_BASE_DIR "include/${PROJECT_NAME}" CACHE STRING "include base directory" FORCE)
include_directories(${CMAKE_SOURCE_DIR}/utils)

# build type
if (NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)
   set (CMAKE_BUILD_TYPE Release)
endif ()

set (V3D_DIR ${CMAKE_CURRENT_SOURCE_DIR})
set (V3D_INCLUDE_DIRS
  ${V3D_DIR}
  ${V3D_DIR}/SuiteSparse/COLAMD/Include
  ${V3D_DIR}/SuiteSparse/UFconfig)

include (Config/v3d_macros.cmake)

include (Config/local_config.cmake)

include_directories(${V3D_INCLUDE_DIRS} ${EXTRA_INC_DIRS})
link_directories(${PROJECT_BINARY_DIR}/SuiteSparse/export/lib)

source_group("Base" REGULAR_EXPRESSION Base/.*cpp|Base.*h)
set (BASE_SRC
    Base/v3d_exception.h
    Base/v3d_serialization.h
    Base/v3d_vrmlio.h
)
if (V3DLIB_ENABLE_SOCKETS)
    set (BASE_SRC ${BASE_SRC} Base/v3d_socket.h)
endif (V3DLIB_ENABLE_SOCKETS)

source_group("Math" REGULAR_EXPRESSION Math/.*cpp|Math.*h)
set (MATH_HEADERS
    Math/v3d_linear.h
    Math/v3d_linearbase.h
    Math/v3d_mathutilities.h
    Math/v3d_nonlinlsq.h
    Math/v3d_optimization.h
    Math/v3d_linear_tnt.h
)

set (MATH_SRC
    ${MATH_HEADERS}
    Math/v3d_nonlinlsq.cpp
    Math/v3d_optimization.cpp
    Math/v3d_optimization_lm.cpp
)

source_group("Geometry" REGULAR_EXPRESSION Geometry/.*cpp|Geometry.*h)
set (GEOMETRY_HEADERS
    Geometry/v3d_cameramatrix.h
    Geometry/v3d_distortion.h
    Geometry/v3d_metricbundle.h
    Geometry/v3d_stereobundle.h
)

set (GEOMETRY_SRC
    ${GEOMETRY_HEADERS}
    Geometry/v3d_metricbundle.cpp
    Geometry/v3d_stereobundle.cpp
)

set (ALL_SRC
    ${BASE_SRC} ${MATH_SRC} ${GEOMETRY_SRC} ${GL_SRC} ${CUDA_SRC}
)

add_subdirectory(SuiteSparse/COLAMD/Lib)
add_subdirectory(SuiteSparse/LDL/Lib)
add_library(V3D ${ALL_SRC})

install(FILES ${BASE_SRC} DESTINATION include/Base)
install(FILES ${MATH_HEADERS} DESTINATION include/Math)
install(FILES ${GEOMETRY_HEADERS} DESTINATION include/Geometry)
install (TARGETS V3D EXPORT depends DESTINATION lib)

add_subdirectory(Apps)

set(PROJECT_LIBRARY_LIST V3D colamd ldl)
add_subdirectory(cmake)
