module dssg.server;

import dssg.defaults;
import dssg.messages;
import std.stdio;
import vibe.core.core : runEventLoop;
import vibe.http.fileserver;
import vibe.http.router;
import vibe.http.server;

int serveProject(ushort port)
{
    writeln(startingServerMsg);

    auto settings = new HTTPServerSettings;
    settings.sessionStore = new MemorySessionStore;
    settings.port = port;
    settings.bindAddresses = ["::1", "127.0.0.1"];

    auto router = new URLRouter;
    router.get("*", serveStaticFiles(buildRoot));
    
    listenHTTP(settings, router);

    return runEventLoop();
}