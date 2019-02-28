# GNU Make project makefile autogenerated by Premake

ifndef config
  config=debug_posix_x64
endif

ifndef verbose
  SILENT = @
endif

.PHONY: clean prebuild prelink

ifeq ($(config),debug_posix_x64)
  RESCOMP = windres
  TARGETDIR = ../bin/tests
  TARGET = $(TARGETDIR)/test_debug_posix_x64_MMap
  OBJDIR = obj/POSIX_x64/Debug/TestsMMAP
  DEFINES += -DDEBUG
  INCLUDES += -I../third_party -I../include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -g -Wall -Wextra -Werror -std=c++11
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -g -Wall -Wextra -Werror -std=c++11
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS += ../bin/Debug/libFileReaderMMap.a
  LDDEPS += ../bin/Debug/libFileReaderMMap.a
  ALL_LDFLAGS += $(LDFLAGS)
  LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
	@echo Running postbuild commands
	.././bin/tests/test_debug_posix_x64_MMap
  endef
all: prebuild prelink $(TARGET)
	@:

endif

ifeq ($(config),debug_win64)
  RESCOMP = windres
  TARGETDIR = ../bin/tests
  TARGET = $(TARGETDIR)/test_debug_win64_MMap.exe
  OBJDIR = obj/win64/Debug/TestsMMAP
  DEFINES += -DDEBUG
  INCLUDES += -I../third_party -I../include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -Werror -g -Wall -Wextra -Wall -Wextra -Werror -std=c++11
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -Werror -g -Wall -Wextra -Wall -Wextra -Werror -std=c++11
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS +=
  LDDEPS +=
  ALL_LDFLAGS += $(LDFLAGS)
  LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
	@echo Running postbuild commands
	.././bin/tests/test_debug_win64_MMap
  endef
all: prebuild prelink $(TARGET)
	@:

endif

ifeq ($(config),release_posix_x64)
  RESCOMP = windres
  TARGETDIR = ../bin/tests
  TARGET = $(TARGETDIR)/test_release_posix_x64_MMap
  OBJDIR = obj/POSIX_x64/Release/TestsMMAP
  DEFINES += -DNDEBUG
  INCLUDES += -I../third_party -I../include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -O2 -Wall -Wextra -Werror -std=c++11
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -O2 -Wall -Wextra -Werror -std=c++11
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS += ../bin/Release/libFileReaderMMap.a
  LDDEPS += ../bin/Release/libFileReaderMMap.a
  ALL_LDFLAGS += $(LDFLAGS) -s
  LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
	@echo Running postbuild commands
	.././bin/tests/test_release_posix_x64_MMap
  endef
all: prebuild prelink $(TARGET)
	@:

endif

ifeq ($(config),release_win64)
  RESCOMP = windres
  TARGETDIR = ../bin/tests
  TARGET = $(TARGETDIR)/test_release_win64_MMap.exe
  OBJDIR = obj/win64/Release/TestsMMAP
  DEFINES += -DNDEBUG
  INCLUDES += -I../third_party -I../include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -Werror -O2 -Wall -Wextra -Wall -Wextra -Werror -std=c++11
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -Werror -O2 -Wall -Wextra -Wall -Wextra -Werror -std=c++11
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS +=
  LDDEPS +=
  ALL_LDFLAGS += $(LDFLAGS) -s
  LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
	@echo Running postbuild commands
	.././bin/tests/test_release_win64_MMap
  endef
all: prebuild prelink $(TARGET)
	@:

endif

OBJECTS := \
	$(OBJDIR)/file_reader_tests.o \
	$(OBJDIR)/test_config_main.o \

RESOURCES := \

CUSTOMFILES := \

SHELLTYPE := posix
ifeq (.exe,$(findstring .exe,$(ComSpec)))
	SHELLTYPE := msdos
endif

$(TARGET): $(GCH) ${CUSTOMFILES} $(OBJECTS) $(LDDEPS) $(RESOURCES) | $(TARGETDIR)
	@echo Linking TestsMMAP
	$(SILENT) $(LINKCMD)
	$(POSTBUILDCMDS)

$(CUSTOMFILES): | $(OBJDIR)

$(TARGETDIR):
	@echo Creating $(TARGETDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(TARGETDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(TARGETDIR))
endif

$(OBJDIR):
	@echo Creating $(OBJDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif

clean:
	@echo Cleaning TestsMMAP
ifeq (posix,$(SHELLTYPE))
	$(SILENT) rm -f  $(TARGET)
	$(SILENT) rm -rf $(OBJDIR)
else
	$(SILENT) if exist $(subst /,\\,$(TARGET)) del $(subst /,\\,$(TARGET))
	$(SILENT) if exist $(subst /,\\,$(OBJDIR)) rmdir /s /q $(subst /,\\,$(OBJDIR))
endif

prebuild:
	$(PREBUILDCMDS)

prelink:
	$(PRELINKCMDS)

ifneq (,$(PCH))
$(OBJECTS): $(GCH) $(PCH) | $(OBJDIR)
$(GCH): $(PCH) | $(OBJDIR)
	@echo $(notdir $<)
	$(SILENT) $(CXX) -x c++-header $(ALL_CXXFLAGS) -o "$@" -MF "$(@:%.gch=%.d)" -c "$<"
else
$(OBJECTS): | $(OBJDIR)
endif

$(OBJDIR)/file_reader_tests.o: ../tests/file_reader_tests.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/test_config_main.o: ../tests/test_config_main.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"

-include $(OBJECTS:%.o=%.d)
ifneq (,$(PCH))
  -include $(OBJDIR)/$(notdir $(PCH)).d
endif