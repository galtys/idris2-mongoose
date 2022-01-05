all: mongoose libs ui

IDRIS := idris2
IDRIS_LIB_DIR := $(shell ${IDRIS} --libdir)
LIBS := ${IDRIS_LIB_DIR}/lib

libs: wrap_libmongoose.c 
	cc -shared wrap_libmongoose.c mongoose.c -o libmongoose.so
	cp libmongoose.so  ${LIBS}/libmongoose.so
	rm libmongoose.so

ui : ui.ipkg
	idris2 --build ui.ipkg

mongoose: mongoose.ipkg
	idris2 --build mongoose.ipkg
clean:
	idris2 --clean mongoose.ipkg

