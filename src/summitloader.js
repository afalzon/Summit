(function () {
  const runtime =
    (typeof browser !== "undefined" && browser.runtime) ||
    (typeof chrome !== "undefined" && chrome.runtime);
  if (!runtime || typeof runtime.getURL !== "function") {
    return;
  }
  const script = document.createElement("script");
  script.src = runtime.getURL("scripts/summit.js");
  (document.head || document.documentElement).appendChild(script);
})();
