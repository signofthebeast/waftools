#------------------------------------------------------------------------------
# WAFTOOLS generated makefile
# version: 0.1.4
# waf: 1.7.15
#------------------------------------------------------------------------------

SHELL=/bin/sh

# commas, spaces and tabs:
sp:= 
sp+= 
tab:=$(sp)$(sp)$(sp)$(sp)
comma:=,

#------------------------------------------------------------------------------
# definition of build and install locations
#------------------------------------------------------------------------------
ifeq ($(TOP),)
TOP=$(CURDIR)
OUT=$(TOP)/build
else
OUT=$(subst $(sp),/,$(call rptotop) build $(call rpofcomp))
endif

PREFIX?=$(HOME)
BINDIR?=$(PREFIX)/bin
LIBDIR?=$(PREFIX)/lib

#------------------------------------------------------------------------------
# component data
#------------------------------------------------------------------------------
BIN=cxxhello
OUTPUT=$(OUT)/$(BIN)

SOURCES= \
	src/hello.cpp

OBJECTS=$(SOURCES:.cpp=.1.o)

DEFINES+=
DEFINES:=$(addprefix -D,$(DEFINES))

INCLUDES+= \
	

HEADERS:=$(foreach inc,$(INCLUDES),$(wildcard $(inc)/*.h))
INCLUDES:=$(addprefix -I,$(INCLUDES))

CXXFLAGS+=

LINKFLAGS+=

RPATH+=
RPATH:= $(addprefix -Wl$(comma)-rpath$(comma),$(RPATH))

LIBPATH_ST+=
LIBPATH_ST:= $(addprefix -L,$(LIBPATH_ST))

LIB_ST+=
LIB_ST:= $(addprefix -l,$(LIB_ST))

LIBPATH_SH+=
LIBPATH_SH:= $(addprefix -L,$(LIBPATH_SH))

LINK_ST= -Wl,-Bstatic $(LIBPATH_ST) $(LIB_ST)

LIB_SH+=
LIB_SH:= $(addprefix -l,$(LIB_SH))

LINK_SH= -Wl,-Bdynamic $(LIBPATH_SH) $(LIB_SH)

#------------------------------------------------------------------------------
# returns the relative path of this component from the top directory
#------------------------------------------------------------------------------
define rpofcomp
$(subst $(subst ~,$(HOME),$(TOP))/,,$(CURDIR))
endef

#------------------------------------------------------------------------------
# returns the relative path of this component to the top directory
#------------------------------------------------------------------------------
define rptotop
$(foreach word,$(subst /,$(sp),$(call rpofcomp)),..)
endef

#------------------------------------------------------------------------------
# define targets
#------------------------------------------------------------------------------
commands= build clean install uninstall all

.DEFAULT_GOAL=all

#------------------------------------------------------------------------------
# definitions of recipes (i.e. make targets)
#------------------------------------------------------------------------------
all: build
	
build: $(OBJECTS)
	$(CXX) $(LINKFLAGS) $(addprefix $(OUT)/,$(OBJECTS)) -o $(OUTPUT) $(RPATH) $(LINK_ST) $(LINK_SH)

clean:
	$(foreach obj,$(OBJECTS),rm -f $(OUT)/$(obj);)	
	rm -f $(OUTPUT)

install: build
	mkdir -p $(BINDIR)
	cp $(OUTPUT) $(BINDIR)
	
uninstall:
	rm -f $(BINDIR)/$(BIN)

$(OBJECTS): $(HEADERS)
	mkdir -p $(OUT)/$(dir $@)
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(DEFINES) $(subst .1.o,.cpp,$@) -c -o $(OUT)/$@

.PHONY: $(commands)

