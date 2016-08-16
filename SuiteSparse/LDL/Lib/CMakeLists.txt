cmake_minimum_required(VERSION 2.6)
project(ldl)

include_directories(../Include ../../UFconfig)


set(${PROJECT_NAME}_HEADERS   ../Include/ldl.h 
                              )

set(${PROJECT_NAME}_SRC ../Source/ldl.c
			../Source/ldl_l.c
			)
					
add_library(${PROJECT_NAME} STATIC ${${PROJECT_NAME}_SRC} 
        ${${PROJECT_NAME}_HEADERS})
					

install(FILES ${${PROJECT_NAME}_HEADERS} DESTINATION include)
install (TARGETS ${PROJECT_NAME} EXPORT depends DESTINATION lib)
