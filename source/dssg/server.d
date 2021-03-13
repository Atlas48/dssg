// A simple web server

module dssg.server;

import dssg.messages;
import dssg.sharedvalues;
import std.stdio;
import vibe.core.core : runEventLoop;
import vibe.http.fileserver;
import vibe.http.router;
import vibe.http.server;

int serveProject(ushort port)
{
    writeln(startingServerMsg);

    auto settings = new HTTPServerSettings;
    settings.port = port;
    settings.bindAddresses = ["::1", "127.0.0.1"];
    settings.accessLogToConsole = true;

    auto router = new URLRouter;
    router.get("*", serveStaticFiles(buildRoot));
    
    auto l = listenHTTP(settings, router);
	scope (exit) l.stopListening();

    return runEventLoop();
}