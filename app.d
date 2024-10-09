import serverino.daemon;
import serverino;
import std.logger;

mixin ServerinoMain;

@endpoint @route!("/api/v1/sequences") void sequences(Request request, Output output) {
   import std.conv : to;

   if (request.method == Request.Method.Get) {
      trace(request.toString);

      tracef("pp:%s, page:%s", request.get.has("per_page"), request.get.has("page"));
      size_t page = request.get.read("page", "0").to!size_t;
      size_t perPage = request.get.read("per_page", "100").to!size_t;
      tracef("pp:%d, page:%d", perPage, page);
      output.status = 206; // partial
      output.addHeader("content-type", "application/json");
      output ~= "ok";
   } else {
      output.status = 405;
   }
}

