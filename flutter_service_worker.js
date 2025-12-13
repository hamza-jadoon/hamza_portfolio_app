'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "6e39be3d53185e7ae4b985da055bbdbe",
"version.json": "1419348d20f102cb3ff73b1ab95c3c71",
"index.html": "6b7e0e36604a4e1fc3b14b90feb961f0",
"/": "6b7e0e36604a4e1fc3b14b90feb961f0",
"main.dart.js": "80adb8b01d572c555e167cf7722e4bf4",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "d6786973c3b8d432b04c6292a00e582a",
"assets/AssetManifest.json": "dd65cef2a0c430bb6c027a9023927795",
"assets/NOTICES": "697ce0d9f5d4039ef63fa35f8030262d",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "5babb63d2e7eec510f2d5dc51654ff1b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "717acd156c04e322186a5fb6eccc7b86",
"assets/fonts/MaterialIcons-Regular.otf": "9b77c71956c6fd81f04b7029a8861e88",
"assets/assets/images/jadoon.png": "401187b55d1d129e1123cbf119158644",
"assets/assets/images/mental.png": "e7751faa7ee57e7b4f7e3115e0ce1eab",
"assets/assets/images/bedtime.png": "b2eb9a544af8521a805f9e9b17e02442",
"assets/assets/images/hamza4.png": "26c7d048dedbf2029aaedb5a71558206",
"assets/assets/images/hamza22.png": "50e6bc7e30ff2113d58edd2be180ebc1",
"assets/assets/images/prayertime.png": "2b7331b6a5cea04cc8f7da3158499cb3",
"assets/assets/images/menyou.png": "01453f3cc626927bc781debe37f0171d",
"assets/assets/images/planner.png": "9c71625612bc82ed5686dd41b8ef9f4c",
"assets/assets/images/hamza3.png": "3599b9fb9563bf334e65f8e20f4ce97d",
"assets/assets/images/hamza1.png": "ddc0684811a3d8185d4d3ebf70513c69",
"assets/assets/app_icons/firebase-original.png": "b7696fd2b2f197b3708637ec359ab37e",
"assets/assets/app_icons/uiux.png": "cac1bd327a347cd77cd85894086771a4",
"assets/assets/app_icons/react-original.png": "5ff2a1db5d91e639ddc18bb3eb693d39",
"assets/assets/app_icons/apl-original.png": "bb8802899d13ca81e740897e486b7301",
"assets/assets/app_icons/Vector.png": "8fbef675ed5484edf3c91aa8c4d79823",
"assets/assets/app_icons/github.png": "dde207daf9cad0c713dcbee27838732c",
"assets/assets/app_icons/openal-original.png": "7368822a68673249c43c78e5c481ab08",
"assets/assets/app_icons/http.png": "bb8bd19990ef4a23b4a0887869774258",
"assets/assets/app_icons/dart-original.png": "702a032eddea90a75d3d0be248fc2112",
"assets/assets/app_icons/java-original.png": "2f9a11dcc2e4c3b89d8f6016befa0d7e",
"assets/assets/app_icons/css3-original.png": "4f62343427002846cadebf7b572aa3bd",
"assets/assets/app_icons/androidstudio-original.png": "4ccd412930de4926c1ede6d3a725f579",
"assets/assets/app_icons/linkdin.png": "e4a79173e34de6f2ae94720b24513fad",
"assets/assets/app_icons/html5-original.png": "3768ce284d6bfa71a327027da8095365",
"assets/assets/app_icons/sql-server.png": "7780db8b6281192e789a90e017e5bcdc",
"assets/assets/app_icons/nodejs-original.png": "33cf8cd4015161696ba742f1c089f7dc",
"assets/assets/app_icons/github-original.png": "b6e204b52431ac9ae3206c419c86213e",
"assets/assets/app_icons/swift-original.png": "8ef8c936fae2c7a644e22f67c1e2246d",
"assets/assets/app_icons/apl-plain.png": "1acca1d6d765f7723fde9cf2e182b50d",
"assets/assets/app_icons/flutter-original.png": "a2c21a398ece69d9d24ad12ac7bd96b6",
"assets/assets/app_icons/python-original.png": "692e0e241a52eab20c5518ff0da87821",
"assets/assets/app_icons/figma-original.png": "c08a45abf932b77d836e099b428cb6c1",
"assets/assets/app_icons/git-original.png": "bd469ba4eea2a940fbe562bd10d11489",
"assets/assets/app_icons/kotlin-original.png": "ccc21f6e92c51606aa76b74675af6743",
"assets/assets/app_icons/javascript-original.png": "5dfc64a8540882ccfe060ea64954b977",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
