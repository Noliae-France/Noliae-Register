(() => {
  const parts = location.hostname.split(".");
  const local = parts.length < 3;
  const app = name => local ? "/" : `${location.protocol}//${name}.${parts.slice(1).join(".")}`;
  document.querySelectorAll("[data-app]").forEach(link => link.href = app(link.dataset.app));
  const api = local ? location.origin : `${location.protocol}//api.${parts.slice(1).join(".")}`;
  fetch(`${api}/v1/branding`, { credentials: "include" }).then(r => r.ok ? r.json() : null).then(brand => {
    if (!brand) return;
    document.querySelectorAll("[data-app]").forEach(link => link.href = brand[`${link.dataset.app}_url`] || link.href);
    if (brand.name && brand.name !== "NolCore") document.querySelectorAll("[data-brand]").forEach(node => node.textContent = brand.name);
  }).catch(() => {});
})();
