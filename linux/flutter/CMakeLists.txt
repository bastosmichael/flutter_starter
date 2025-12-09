cmake_minimum_required(VERSION 3.10)

# Path to ephemeral Flutter artifacts.
set(EPHEMERAL_DIR "${CMAKE_CURRENT_SOURCE_DIR}/ephemeral")
set(WRAPPER_ROOT "${EPHEMERAL_DIR}/cpp_client_wrapper")

if(NOT DEFINED FLUTTER_ROOT)
  message(FATAL_ERROR "FLUTTER_ROOT must be defined when configuring the Flutter Linux runner.")
endif()

# Ensure the ephemeral directory exists before generating artifacts.
file(MAKE_DIRECTORY "${EPHEMERAL_DIR}")

# Flutter libraries and artifacts produced by the toolchain.
set(FLUTTER_LIBRARY "${EPHEMERAL_DIR}/libflutter_linux_gtk.so")
set(FLUTTER_ICU_DATA_FILE "${EPHEMERAL_DIR}/icudtl.dat")
set(FLUTTER_LIBRARY_HEADERS
  "${WRAPPER_ROOT}/include"
  "${EPHEMERAL_DIR}"
)
set(FLUTTER_LIBRARY_LINK_LIBRARIES
  "${FLUTTER_LIBRARY}"
  dl
  pthread
  rt
  gtk-3
  gdk-3
  gio-2.0
  glib-2.0
  gobject-2.0
  atk-1.0
  cairo-gobject
  pangocairo-1.0
  pango-1.0
  cairo
  gdk_pixbuf-2.0
)

# Snapshot artifacts used when bundling the application.
set(FLUTTER_VM_SNAPSHOT_DATA "${EPHEMERAL_DIR}/vm_snapshot_data")
set(FLUTTER_VM_SNAPSHOT_INSTRUCTIONS "${EPHEMERAL_DIR}/vm_snapshot_instr")
set(FLUTTER_ISOLATE_SNAPSHOT_DATA "${EPHEMERAL_DIR}/isolate_snapshot_data")
set(FLUTTER_ISOLATE_SNAPSHOT_INSTRUCTIONS "${EPHEMERAL_DIR}/isolate_snapshot_instr")

# Flutter build configuration used when invoking the tool backend.
set(FLUTTER_TARGET_PLATFORM "linux-x64" CACHE STRING "")
set(FLUTTER_BUILD_MODE "$<IF:$<CONFIG:Debug>,debug,$<IF:$<CONFIG:Profile>,profile,release>>" CACHE STRING "")
set(FLUTTER_TARGET_FILE "${CMAKE_CURRENT_SOURCE_DIR}/../../lib/main.dart" CACHE STRING "")
set(FLUTTER_ASSET_DIR "${CMAKE_CURRENT_BINARY_DIR}/flutter_assets" CACHE STRING "")

# Flutter tool runner used to materialize the engine and snapshot artifacts.
set(FLUTTER_TOOL "${FLUTTER_ROOT}/packages/flutter_tools/bin/tool_backend.sh")
set(FLUTTER_TOOL_ENVIRONMENT
  "FLUTTER_ROOT=${FLUTTER_ROOT}"
  "PROJECT_DIR=${CMAKE_CURRENT_SOURCE_DIR}/../.."
  "FLUTTER_TARGET=${FLUTTER_TARGET_FILE}"
  "FLUTTER_TARGET_PLATFORM=${FLUTTER_TARGET_PLATFORM}"
  "FLUTTER_BUILD_MODE=${FLUTTER_BUILD_MODE}"
  "FLUTTER_ASSET_DIR=${FLUTTER_ASSET_DIR}"
)

# Export important paths back to the parent scope so the runner CMakeLists
# can consume them when wiring up install rules.
set(FLUTTER_LIBRARY "${FLUTTER_LIBRARY}" PARENT_SCOPE)
set(FLUTTER_ICU_DATA_FILE "${FLUTTER_ICU_DATA_FILE}" PARENT_SCOPE)
set(FLUTTER_LIBRARY_HEADERS "${FLUTTER_LIBRARY_HEADERS}" PARENT_SCOPE)
set(FLUTTER_LIBRARY_LINK_LIBRARIES "${FLUTTER_LIBRARY_LINK_LIBRARIES}" PARENT_SCOPE)
set(FLUTTER_VM_SNAPSHOT_DATA "${FLUTTER_VM_SNAPSHOT_DATA}" PARENT_SCOPE)
set(FLUTTER_VM_SNAPSHOT_INSTRUCTIONS "${FLUTTER_VM_SNAPSHOT_INSTRUCTIONS}" PARENT_SCOPE)
set(FLUTTER_ISOLATE_SNAPSHOT_DATA "${FLUTTER_ISOLATE_SNAPSHOT_DATA}" PARENT_SCOPE)
set(FLUTTER_ISOLATE_SNAPSHOT_INSTRUCTIONS "${FLUTTER_ISOLATE_SNAPSHOT_INSTRUCTIONS}" PARENT_SCOPE)

# GTK dependency for the runner target.
find_package(PkgConfig REQUIRED)
pkg_check_modules(GTK REQUIRED IMPORTED_TARGET gtk+-3.0)

add_library(flutter INTERFACE)
target_include_directories(flutter INTERFACE ${FLUTTER_LIBRARY_HEADERS})
target_link_libraries(flutter INTERFACE ${FLUTTER_LIBRARY_LINK_LIBRARIES})

# Build the Flutter artifacts on demand using the Flutter backend tool.
set(GENERATED_STAMP "${EPHEMERAL_DIR}/flutter_linux_gtk.stamp")
add_custom_command(
  OUTPUT
    "${FLUTTER_LIBRARY}"
    "${FLUTTER_ICU_DATA_FILE}"
    "${FLUTTER_VM_SNAPSHOT_DATA}"
    "${FLUTTER_VM_SNAPSHOT_INSTRUCTIONS}"
    "${FLUTTER_ISOLATE_SNAPSHOT_DATA}"
    "${FLUTTER_ISOLATE_SNAPSHOT_INSTRUCTIONS}"
    "${GENERATED_STAMP}"
  COMMAND ${CMAKE_COMMAND} -E env ${FLUTTER_TOOL_ENVIRONMENT}
    "${FLUTTER_TOOL}" ${FLUTTER_TARGET_PLATFORM} ${FLUTTER_BUILD_MODE}
  COMMAND ${CMAKE_COMMAND} -E touch "${GENERATED_STAMP}"
  VERBATIM
)

add_library(flutter_wrapper_plugin STATIC IMPORTED)
set_target_properties(flutter_wrapper_plugin PROPERTIES
  IMPORTED_LOCATION "${WRAPPER_ROOT}/libflutter_wrapper_plugin.a"
  INTERFACE_INCLUDE_DIRECTORIES "${WRAPPER_ROOT}/include"
)

add_library(flutter_wrapper_app STATIC IMPORTED)
set_target_properties(flutter_wrapper_app PROPERTIES
  IMPORTED_LOCATION "${WRAPPER_ROOT}/libflutter_wrapper_app.a"
  INTERFACE_INCLUDE_DIRECTORIES "${WRAPPER_ROOT}/include"
)

# Standard build settings applied to the runner target.
function(apply_standard_settings TARGET)
  target_compile_features(${TARGET} PUBLIC cxx_std_14)
  target_compile_options(${TARGET} PRIVATE -Wall -Werror)
  target_compile_options(${TARGET} PRIVATE "$<$<NOT:$<CONFIG:Debug>>:-O3>")
  target_link_libraries(${TARGET} PRIVATE flutter_wrapper_app)
endfunction()

# This target builds the Flutter engine, wrapper, and plugins.
add_custom_target(flutter_assemble DEPENDS
  "${FLUTTER_LIBRARY}"
  "${FLUTTER_ICU_DATA_FILE}"
  "${FLUTTER_VM_SNAPSHOT_DATA}"
  "${FLUTTER_VM_SNAPSHOT_INSTRUCTIONS}"
  "${FLUTTER_ISOLATE_SNAPSHOT_DATA}"
  "${FLUTTER_ISOLATE_SNAPSHOT_INSTRUCTIONS}"
  "${GENERATED_STAMP}"
)
add_dependencies(flutter flutter_assemble)

# Generated plugin build rules.
include("${CMAKE_CURRENT_SOURCE_DIR}/generated_plugins.cmake")
