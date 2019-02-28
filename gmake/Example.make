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
  TARGETDIR = ../bin/example
  TARGET = $(TARGETDIR)/example
  OBJDIR = obj/POSIX_x64/Debug/Example
  DEFINES += -DDEBUG
  INCLUDES += -I../include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -g -Wall -Wextra -Werror
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -g -Wall -Wextra -Werror
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
  endef
all: prebuild prelink $(TARGET)
	@:

endif

ifeq ($(config),debug_win64)
  RESCOMP = windres
  TARGETDIR = ../bin/example
  TARGET = $(TARGETDIR)/example.exe
  OBJDIR = obj/win64/Debug/Example
  DEFINES += -DDEBUG
  INCLUDES += -I../include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -Werror -g -Wall -Wextra -Wall -Wextra -Werror
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -Werror -g -Wall -Wextra -Wall -Wextra -Werror
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
  endef
all: prebuild prelink $(TARGET)
	@:

endif

ifeq ($(config),release_posix_x64)
  RESCOMP = windres
  TARGETDIR = ../bin/example
  TARGET = $(TARGETDIR)/example
  OBJDIR = obj/POSIX_x64/Release/Example
  DEFINES += -DNDEBUG
  INCLUDES += -I../include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -O2 -Wall -Wextra -Werror
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -O2 -Wall -Wextra -Werror
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
  endef
all: prebuild prelink $(TARGET)
	@:

endif

ifeq ($(config),release_win64)
  RESCOMP = windres
  TARGETDIR = ../bin/example
  TARGET = $(TARGETDIR)/example.exe
  OBJDIR = obj/win64/Release/Example
  DEFINES += -DNDEBUG
  INCLUDES += -I../include
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -Werror -O2 -Wall -Wextra -Wall -Wextra -Werror
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -Werror -O2 -Wall -Wextra -Wall -Wextra -Werror
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
  endef
all: prebuild prelink $(TARGET)
	@:

endif

OBJECTS := \
	$(OBJDIR)/example.o \

RESOURCES := \

CUSTOMFILES := \

SHELLTYPE := posix
ifeq (.exe,$(findstring .exe,$(ComSpec)))
	SHELLTYPE := msdos
endif

$(TARGET): $(GCH) ${CUSTOMFILES} $(OBJECTS) $(LDDEPS) $(RESOURCES) | $(TARGETDIR)
	@echo Linking Example
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
	@echo Cleaning Example
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

$(OBJDIR)/example.o: ../src/example.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"

-include $(OBJECTS:%.o=%.d)
ifneq (,$(PCH))
  -include $(OBJDIR)/$(notdir $(PCH)).d
endif