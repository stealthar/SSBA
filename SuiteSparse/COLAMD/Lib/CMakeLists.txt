cmake_minimum_required(VERSION 2.6)
project(colamd)

include_directories(../Include ../../UFconfig)


set(${PROJECT_NAME}_HEADERS   ../Include/colamd.h 
                              ../../UFconfig/UFconfig.h
                              )

set(${PROJECT_NAME}_SRC ../Source/colamd_global.c
			../Source/colamd.c
			../Source/colamd_l.c
			)
					
add_library(${PROJECT_NAME} STATIC ${${PROJECT_NAME}_SRC} 
        ${${PROJECT_NAME}_HEADERS})
					
install(FILES ${${PROJECT_NAME}_HEADERS} DESTINATION include)
install (TARGETS ${PROJECT_NAME} EXPORT depends DESTINATION lib)
