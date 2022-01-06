# idris2-mongoose

This is an mongoose web server wrapper. Work in progress. Many things will be re-organized.

On NixOS and ssuming that `idris2` (and build dependencies) is in your home directory under`.idris2`, run `source rc`. This 
will set your `$PATH` and `LD_LIBRARY_PATH`

Then run `make` and:

1) Start the http (with websocket) server via `./build/exec/ws_serve`
2) Point your web browser to http://localhost:8000

Then open the developer console and you should see output from: `WebTestClient.idr` test program.

