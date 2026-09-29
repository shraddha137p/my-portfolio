// The previous Flutter build registered a service worker at this path that caches the old site.
// Browsers re-check this file on each visit; this version clears those caches, unregisters
// itself and reloads open tabs so returning visitors get the new site.
self.addEventListener("install", () => self.skipWaiting());
self.addEventListener("activate", (event) => {
  event.waitUntil(
    (async () => {
      for (const key of await caches.keys()) await caches.delete(key);
      await self.registration.unregister();
      for (const client of await self.clients.matchAll({ type: "window" })) client.navigate(client.url);
    })()
  );
});
