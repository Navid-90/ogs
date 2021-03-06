# A list of processes to be build. Also used in the ProcessLib to select
# processes to be build.
set(ProcessesList
    ComponentTransport
    GroundwaterFlow
    HT
    HeatConduction
    HeatTransportBHE
    HydroMechanics
    LiquidFlow
    LIE
    PhaseField
    RichardsComponentTransport
    RichardsFlow
    RichardsMechanics
    SmallDeformation
    SmallDeformationNonlocal
    TES
    ThermalTwoPhaseFlowWithPP
    ThermoHydroMechanics
    ThermoMechanicalPhaseField
    ThermoMechanics
    TwoPhaseFlowWithPP
    TwoPhaseFlowWithPrho)

# Add a cmake option for each process.
foreach(process ${ProcessesList})
    option(OGS_BUILD_PROCESS_${process} "Build the ${process} process." ON)
endforeach()

set(OGS_BUILD_PROCESSES
    ""
    CACHE STRING "Semicolon-separated list of processes to build")
if(NOT OGS_BUILD_CLI)
    set(OGS_BUILD_PROCESSES OFF "" CACHE INTERNAL "")
endif()
if(NOT "${OGS_BUILD_PROCESSES}" STREQUAL "")
    if(${OGS_BUILD_PROCESSES})
        foreach(process ${OGS_BUILD_PROCESSES})
            if(NOT "${process}" IN_LIST ProcessesList)
                message(
                    FATAL_ERROR
                        "${process} given in OGS_BUILD_PROCESSES is "
                        "not a valid process name! Valid names are ${ProcessesList}"
                    )
            endif()
        endforeach()
        message(STATUS "Enabled processes:")
    else()
        message(STATUS "All processes disabled.")
    endif()
    foreach(process ${ProcessesList})
        if("${process}" IN_LIST OGS_BUILD_PROCESSES)
            set(OGS_BUILD_PROCESS_${process} ON CACHE BOOL "" FORCE)
            message(STATUS "  ${process}")
        else()
            set(OGS_BUILD_PROCESS_${process} OFF CACHE BOOL "" FORCE)
        endif()
    endforeach()
endif()