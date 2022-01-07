all: mongoose libs browser_ws ui_raw

IDRIS := idris2
IDRIS_LIB_DIR := $(shell ${IDRIS} --libdir)
LIBS := ${IDRIS_LIB_DIR}/lib

libs: wrap_libmongoose.c 
	cc -shared wrap_libmongoose.c mongoose.c -o libmongoose.so

browser_ws : browser_ws.ipkg
	idris2 --build browser_ws.ipkg
ui_raw : ui_raw.ipkg
	idris2 --build ui_raw.ipkg

mongoose: mongoose.ipkg
	idris2 --build mongoose.ipkg
clean:
	idris2 --clean mongoose.ipkg

install: browser_ws.ipkg mongoose.ipkg libs
	idris2 --install mongoose.ipkg
	idris2 --install browser_ws.ipkg
	cp libmongoose.so  ${LIBS}/libmongoose.so
	rm libmongoose.so
