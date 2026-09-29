(() => {
  "use strict";

  const D = window.PORTFOLIO;
  if (!D) return;
  if (D.theme) document.documentElement.dataset.theme = D.theme;

  const $ = (s, r = document) => r.querySelector(s);
  const $$ = (s, r = document) => [...r.querySelectorAll(s)];
  const esc = (v = "") =>
    String(v).replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));
  const reduceMotion = matchMedia("(prefers-reduced-motion: reduce)").matches;
  const finePointer = matchMedia("(hover: hover) and (pointer: fine)").matches;

  /* ------------------------------------------------------------------ icons */
  const svg = (d, extra = "") =>
    `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" ${extra}>${d}</svg>`;
  const ICONS = {
    arrow: svg('<path d="M5 12h14M13 6l6 6-6 6"/>'),
    arrowDown: svg('<path d="M12 5v14M6 13l6 6 6-6"/>'),
    arrowUp: svg('<path d="M12 19V5M6 11l6-6 6 6"/>'),
    external: svg('<path d="M7 17 17 7M8 7h9v9"/>'),
    download: svg('<path d="M12 4v11M7 10l5 5 5-5M5 20h14"/>'),
    mail: svg('<rect x="3" y="5" width="18" height="14" rx="3"/><path d="m4 7 8 6 8-6"/>'),
    send: svg('<path d="M21 3 10 14M21 3l-7 18-4-7-7-4 18-7Z"/>'),
    copy: svg('<rect x="9" y="9" width="11" height="11" rx="2.5"/><path d="M5 15V6a2 2 0 0 1 2-2h8"/>'),
    check: svg('<path d="m5 12 5 5 9-10"/>'),
    home: svg('<path d="M4 11 12 4l8 7v8a1 1 0 0 1-1 1h-5v-6h-4v6H5a1 1 0 0 1-1-1v-8Z"/>'),
    grid: svg('<rect x="4" y="4" width="7" height="9" rx="2"/><rect x="13" y="4" width="7" height="5" rx="2"/><rect x="13" y="11" width="7" height="9" rx="2"/><rect x="4" y="15" width="7" height="5" rx="2"/>'),
    timeline: svg('<circle cx="6" cy="6" r="2"/><circle cx="6" cy="18" r="2"/><path d="M6 8v8M11 6h9M11 18h9"/>'),
    user: svg('<circle cx="12" cy="8" r="4"/><path d="M4 20c1.5-3.5 4.5-5 8-5s6.5 1.5 8 5"/>'),
    star: svg('<path d="m12 3 2.6 5.6 6 .7-4.5 4.1 1.2 6L12 16.4 6.7 19.4l1.2-6L3.4 9.3l6-.7L12 3Z" fill="currentColor"/>'),
    play: svg('<path d="M5 3.5v17a.8.8 0 0 0 1.2.7l14.5-8.5a.8.8 0 0 0 0-1.4L6.2 2.8A.8.8 0 0 0 5 3.5Z"/>'),
    github: svg('<path d="M9 19c-4.3 1.4-4.3-2.5-6-3m12 5v-3.5c0-1 .1-1.4-.5-2 2.8-.3 5.5-1.4 5.5-6a4.6 4.6 0 0 0-1.3-3.2 4.2 4.2 0 0 0-.1-3.2s-1.1-.3-3.5 1.3a12.3 12.3 0 0 0-6.2 0C6.5 2.8 5.4 3.1 5.4 3.1a4.2 4.2 0 0 0-.1 3.2A4.6 4.6 0 0 0 4 9.5c0 4.6 2.7 5.7 5.5 6-.6.6-.6 1.2-.5 2V21"/>'),
    linkedin: svg('<rect x="3" y="3" width="18" height="18" rx="4"/><path d="M8 10v7M8 7v.01M12 17v-4a2 2 0 0 1 4 0v4M12 10v7"/>'),
    x: svg('<path d="M4 4l16 16M20 4 4 20"/>'),
    instagram: svg('<rect x="3" y="3" width="18" height="18" rx="5"/><circle cx="12" cy="12" r="4"/><path d="M17.5 6.5v.01"/>'),
    medium: svg('<circle cx="7" cy="12" r="4"/><ellipse cx="15.5" cy="12" rx="2" ry="4"/><path d="M20.5 8v8"/>'),
    dribbble: svg('<circle cx="12" cy="12" r="9"/><path d="M8 4c3 4 5 9 6 16M3.5 10c5 .5 10-.5 14.5-4.5M6 19c2.5-4 7-6 14.5-4.5"/>'),
  };
  const icon = (name) => `<span class="i" data-icon="${name}">${ICONS[name] || ""}</span>`;

  /* --------------------------------------------------------------- binding */
  const [firstName, ...rest] = D.name.split(" ");
  const ctx = { ...D, firstName, lastName: rest.join(" ") };
  const get = (path) => path.split(".").reduce((o, k) => (o == null ? o : o[k]), ctx);

  $$("[data-bind]").forEach((el) => {
    const v = get(el.dataset.bind);
    if (v == null || v === "") el.hidden = true;
    // *word* in data.js renders in the accent gradient
    else el.innerHTML = esc(v).replace(/\*(.+?)\*/g, '<span class="grad-text">$1</span>');
  });
  $$('[data-href="resume"]').forEach((el) => (D.resume ? (el.href = D.resume) : (el.hidden = true)));
  $$('[data-href="mailto"]').forEach((el) => (el.href = `mailto:${D.email}`));
  $$(".i[data-icon]").forEach((el) => { if (!el.innerHTML) el.innerHTML = ICONS[el.dataset.icon] || ""; });
  $("#year").textContent = new Date().getFullYear();

  /* ---------------------------------------------------------- phone mockup */
  // Placeholder screens shown until real screenshots are added (data.js → screenshots / mock)
  const TAB = `<div class="mock__tab"><b></b><b></b><b></b><b></b></div>`;
  const SCREENS = {
    feed: (n) => `
      <div class="mock__hero"><small>Welcome back</small><strong>${n}</strong></div>
      <div class="mock__search"></div>
      <div class="mock__cards"><i></i><i></i></div>
      <div class="mock__list"><i></i><i></i><i></i></div>${TAB}`,
    stats: (n) => `
      <div class="mock__hero"><small>This week</small><strong>${n}</strong></div>
      <div class="m-kpi"><small>Active users</small><strong>12.4k</strong><em>+18%</em></div>
      <div class="m-bars"><i style="height:40%"></i><i style="height:62%"></i><i style="height:48%"></i><i style="height:75%"></i><i style="height:100%"></i><i style="height:66%"></i><i style="height:54%"></i></div>
      <div class="mock__list"><i></i><i></i></div>${TAB}`,
    shop: (n) => `
      <div class="mock__hero"><small>Discover</small><strong>${n}</strong></div>
      <div class="m-pills"><b></b><b></b><b></b></div>
      <div class="m-grid"><i></i><i></i><i></i><i></i></div>${TAB}`,
    tasks: (n) => `
      <div class="mock__hero"><small>Today</small><strong>${n}</strong></div>
      <div class="m-ring"><span>72%</span></div>
      <div class="m-checks"><i class="on"></i><i class="on"></i><i></i><i></i></div>${TAB}`,
    chat: (n) => `
      <div class="mock__hero"><small>Online now</small><strong>${n}</strong></div>
      <div class="m-chat"><i></i><i class="me s"></i><i class="l"></i><i class="me"></i><i class="s"></i><i class="me l"></i></div>
      <div class="m-input"></div>`,
  };
  const VARIANTS = ["shop", "tasks", "stats", "chat", "feed"];

  const phone = ({ src = "", alt = "", accent = "", name = "", variant = "feed", eager = false, decorative = false }) => {
    const label = decorative ? 'aria-hidden="true"' : `role="img" aria-label="${esc(alt || `${name} app preview`)}"`;
    const screen = src
      ? `<img src="${esc(src)}" alt="${decorative ? "" : esc(alt)}" width="390" height="845" decoding="async" ${eager ? 'fetchpriority="high"' : 'loading="lazy"'}>`
      : `<div class="mock"${accent ? ` style="--app:${esc(accent)}"` : ""} ${label}>${(SCREENS[variant] || SCREENS.feed)(esc(name))}</div>`;
    return `<div class="phone"><div class="phone__screen">${screen}</div><span class="phone__island" aria-hidden="true"></span></div>`;
  };

  /* ------------------------------------------------------------------ hero */
  const H = D.hero;
  if (!H.available) {
    $("#status").classList.add("is-busy");
    $('#status [data-bind="hero.availability"]').textContent = "Currently booked";
  }
  $("#heroSocials").innerHTML = (D.socials || [])
    .map((s) => `<li><a href="${esc(s.url)}" target="_blank" rel="noopener me" aria-label="${esc(s.label)}">${icon(s.icon)}</a></li>`)
    .join("");

  /* ---------------------------------------------------------------- impact */
  $("#impactGrid").innerHTML = (H.stats || [])
    .map(
      (s) => `
    <li class="impact__card reveal">
      <strong class="impact__value"><span data-count="${esc(s.value)}">${esc(s.value)}</span>${s.plus ? "<em>+</em>" : ""}</strong>
      <span class="impact__label">${esc(s.label)}</span>
      ${s.note ? `<p class="impact__note">${esc(s.note)}</p>` : ""}
    </li>`
    )
    .join("");

  /* ----------------------------------------------------------------- stack */
  const techItem = (t) => `
    <div class="tech">
      <span class="tech__icon">${t.icon ? `<img src="${esc(t.icon)}" alt="" width="26" height="26" loading="lazy">` : `<b class="grad-text">${esc(t.name[0])}</b>`}</span>
      <span><strong>${esc(t.name)}</strong>${t.note ? `<small>${esc(t.note)}</small>` : ""}</span>
    </div>`;
  const marquee = (items, render, label) => {
    const set = items.map(render);
    return `<div class="marquee__track">
      <ul class="marquee__set" aria-label="${esc(label)}" style="display:contents">${set.map((h) => `<li style="display:contents">${h}</li>`).join("")}</ul>
      ${set.map((h) => h.replace(/^(\s*<\w+)/, '$1 aria-hidden="true"')).join("")}
    </div>`;
  };
  $("#stackRow").innerHTML = marquee(D.stack || [], techItem, "Tech stack");
  $("#capRow").innerHTML = marquee(D.capabilities || [], (c) => `<span class="cap">${esc(c)}</span>`, "Capabilities");

  /* -------------------------------------------------------------- projects */
  const linkBtn = (href, label, ico, title) =>
    href ? `<a class="link-btn" href="${esc(href)}" target="_blank" rel="noopener" aria-label="${esc(`${title}: ${label}`)}">${icon(ico)}${label}</a>` : "";

  const projects = D.projects || [];
  const featuredIdx = Math.max(0, projects.findIndex((p) => p.featured));
  const feat = projects[featuredIdx];
  const others = projects.filter((_, i) => i !== featuredIdx);

  const cardBody = (p, featured) => {
    const L = p.links || {};
    return `
      <div class="card__body">
        ${featured ? `<span class="card__badge">${icon("star")}Featured project</span>` : ""}
        <div class="card__top"><span class="tag">${esc(p.category)}</span>${p.company || p.year ? `<span class="card__year">${esc(p.company || p.year)}</span>` : ""}</div>
        <h3 class="card__title">${esc(p.title)}</h3>
        <p class="card__desc">${esc(p.description)}</p>
        ${featured && p.highlights?.length ? `<ul class="card__highlights">${p.highlights.map((h) => `<li>${esc(h)}</li>`).join("")}</ul>` : ""}
        <ul class="chips" aria-label="Built with">${(p.tech || []).map((t) => `<li>${esc(t)}</li>`).join("")}</ul>
        <div class="card__links">
          ${linkBtn(L.github, "GitHub", "github", p.title)}
          ${linkBtn(L.playStore, "Play Store", "play", p.title)}
          ${linkBtn(L.live, "Live", "external", p.title)}
        </div>
      </div>`;
  };
  const appVar = (p) => (p.accent ? `style="--app:${esc(p.accent)}"` : "");

  // Featured: centre phone + two fanned side phones (uses up to 3 screenshots)
  // Project preview by image type (see data.js): screen · mockup · poster · logo · placeholder
  const preview = (p, variant, eager = false) => {
    const alt = `${p.title} app preview`;
    const lazy = eager ? "" : 'loading="lazy"';
    switch (p.image ? p.imageType : "") {
      case "mockup": return `<img class="shot shot--mockup" src="${esc(p.image)}" alt="${esc(alt)}" decoding="async" ${lazy}>`;
      case "poster": return `<img class="shot shot--poster" src="${esc(p.image)}" alt="${esc(alt)}" decoding="async" ${lazy}>`;
      case "logo":   return `<span class="app-icon"><img src="${esc(p.image)}" alt="${esc(p.title)} logo" decoding="async" ${lazy}></span>`;
      case "screen": return phone({ src: p.image, alt, eager });
      default:       return phone({ accent: p.accent, name: p.title, alt, variant });
    }
  };
  const mediaClass = (p) => (p.image ? ` media--${esc(p.imageType)}` : "");

  const featPhones = () => {
    if (feat.image) return preview(feat, feat.mock, true);
    const shots = feat.screenshots || [];
    const fallback = [feat.mock || "feed", "stats", "chat"];
    return [0, 1, 2]
      .map((n) =>
        phone({
          src: shots[n] || "",
          alt: `${feat.title} screen ${n + 1}`,
          accent: feat.accent,
          name: feat.title,
          variant: fallback[n],
          eager: false,
          decorative: n > 0,
        })
      )
      .join("");
  };

  $("#projects").innerHTML = `
    <div class="work">
      ${feat ? `
      <article class="card-wrap reveal">
        <div class="card card--featured" ${appVar(feat)} data-tilt>
          <div class="card__glow" aria-hidden="true"></div>
          ${cardBody(feat, true)}
          <div class="feat__stage${mediaClass(feat)}">${featPhones()}</div>
        </div>
      </article>` : ""}
      <div class="work-grid">
        ${others
          .map((p, i) => `
          <article class="card-wrap reveal" style="--d:${(i % 2) * 90}ms">
            <div class="card card--row" ${appVar(p)} data-tilt>
              <div class="card__glow" aria-hidden="true"></div>
              ${cardBody(p, false)}
              <div class="card__media${mediaClass(p)}">${preview(p, p.mock || VARIANTS[i % VARIANTS.length])}</div>
            </div>
          </article>`)
          .join("")}
      </div>
      ${others.length > 1 ? `<p class="work-hint" aria-hidden="true">Swipe for more projects →</p>` : ""}
    </div>`;

  /* ------------------------------------------------------------ experience */
  $("#timeline").innerHTML = (D.experience || [])
    .map(
      (e) => `
    <li class="tl reveal">
      <span class="tl__dot" aria-hidden="true"></span>
      <div class="tl__card glass">
        <div class="tl__head"><h3 class="tl__role">${esc(e.role)}</h3>${e.period ? `<span class="tl__period">${esc(e.period)}</span>` : ""}</div>
        <p class="tl__company">${esc(e.company)}${e.type ? ` <span>· ${esc(e.type)}</span>` : ""}</p>
        ${e.summary ? `<p class="tl__summary">${esc(e.summary)}</p>` : ""}
        ${e.points?.length ? `<ul class="tl__points">${e.points.map((x) => `<li>${esc(x)}</li>`).join("")}</ul>` : ""}
        ${e.tech?.length ? `<ul class="chips" aria-label="Tech">${e.tech.map((t) => `<li>${esc(t)}</li>`).join("")}</ul>` : ""}
      </div>
    </li>`
    )
    .join("");

  /* ----------------------------------------------------------------- about */
  const A = D.about || {};
  // Flat Flutter logo: shown until the 3D scene loads, and kept if WebGL is unavailable
  const FLUTTER_SVG = `<svg viewBox="0 0 24 24" aria-hidden="true"><path fill="#54c5f8" d="M14.314 0 2.3 12 6 15.7 21.684.013z"/><path fill="#54c5f8" d="M14.328 11.072 7.857 17.53 15.24 17.532 21.7 11.072z"/><path fill="#01579b" d="M7.857 17.53 14.327 24H21.7l-6.46-6.468z"/></svg>`;
  let media;
  if (A.visual === "flutter3d") {
    media = `
      <div class="scene3d" id="scene3d" role="img" aria-label="3D Flutter logo">
        <div class="scene3d__fallback">${FLUTTER_SVG}</div>
      </div>
      ${(A.chips || []).map((c, i) => `<span class="scene3d__chip scene3d__chip--${i + 1}" aria-hidden="true">${esc(c)}</span>`).join("")}`;
  } else if (A.photo) {
    media = `<img src="${esc(A.photo)}" alt="${esc(A.photoAlt || D.name)}" width="800" height="1000" loading="lazy" decoding="async">`;
  } else {
    media = `<div class="frame__mono" role="img" aria-label="${esc(D.name)}"><span class="grad-text">${esc(D.initials)}</span></div>`;
  }
  $("#aboutMedia").innerHTML = `
    <figure class="frame" style="margin:0">
      <div class="frame__inner${A.visual === "flutter3d" ? " frame__inner--scene" : ""}">${media}</div>
      ${A.caption ? `<figcaption class="frame__caption"><span class="pulse" aria-hidden="true"></span>${esc(A.caption)}</figcaption>` : ""}
    </figure>`;
  $("#aboutText").innerHTML = (A.paragraphs || []).map((p) => `<p>${esc(p)}</p>`).join("");
  $("#aboutFacts").innerHTML = (A.facts || []).map((f) => `<div><dt>${esc(f.label)}</dt><dd>${esc(f.value)}</dd></div>`).join("");

  /* --------------------------------------------------------------- contact */
  $("#socials").innerHTML = (D.socials || [])
    .map((s) => `<li><a href="${esc(s.url)}" target="_blank" rel="noopener me">${icon(s.icon)}${esc(s.label)}</a></li>`)
    .join("");

  // Copy-email buttons: the icon-only one in Contact and the labelled one in the hero
  const copyEmail = async (btn, withLabel) => {
    const original = btn.innerHTML;
    const label = btn.getAttribute("aria-label");
    try {
      await navigator.clipboard.writeText(D.email);
      btn.innerHTML = icon("check") + (withLabel ? "<span>Copied!</span>" : "");
      btn.setAttribute("aria-label", "Email copied");
      setTimeout(() => {
        btn.innerHTML = original;
        label ? btn.setAttribute("aria-label", label) : btn.removeAttribute("aria-label");
      }, 1800);
    } catch {
      location.href = `mailto:${D.email}`;
    }
  };
  const copyBtn = $("#copyEmail");
  copyBtn.addEventListener("click", () => copyEmail(copyBtn, false));
  const heroCopy = $("#heroCopy");
  heroCopy.addEventListener("click", () => copyEmail(heroCopy, true));

  const form = $("#contactForm");
  const status = $("#formStatus");
  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    const fields = $$("input[required], textarea[required]", form);
    fields.forEach((f) => f.setAttribute("aria-invalid", String(!f.checkValidity())));
    const firstBad = fields.find((f) => !f.checkValidity());
    if (firstBad) {
      status.className = "form__status err";
      status.textContent = "Please fill in all fields with a valid email.";
      firstBad.focus();
      return;
    }
    const data = new FormData(form);
    if (data.get("_gotcha")) return;

    if (!D.contact?.formEndpoint) {
      const subject = encodeURIComponent(`Hello from ${data.get("name")}`);
      const body = encodeURIComponent(`${data.get("message")}\n\n${data.get("name")} · ${data.get("email")}`);
      location.href = `mailto:${D.email}?subject=${subject}&body=${body}`;
      status.className = "form__status ok";
      status.textContent = "Opening your email app…";
      return;
    }

    const btn = $("button[type=submit]", form);
    btn.disabled = true;
    status.className = "form__status";
    status.textContent = "Sending…";
    try {
      const res = await fetch(D.contact.formEndpoint, { method: "POST", body: data, headers: { Accept: "application/json" } });
      if (!res.ok) throw new Error(res.status);
      form.reset();
      fields.forEach((f) => f.removeAttribute("aria-invalid"));
      status.className = "form__status ok";
      status.textContent = "Thanks, your message is in. I'll reply soon.";
    } catch {
      status.className = "form__status err";
      status.textContent = `Something went wrong. Email me directly at ${D.email}.`;
    } finally {
      btn.disabled = false;
    }
  });

  /* ================================================================ MOTION */

  // Scroll reveal, with a stagger for children of [data-stagger]
  $$("[data-stagger]").forEach((group) =>
    $$(":scope > .reveal", group).forEach((el, i) => el.style.setProperty("--d", `${i * 90}ms`))
  );
  if ("IntersectionObserver" in window && !reduceMotion) {
    const io = new IntersectionObserver(
      (entries) =>
        entries.forEach((en) => {
          if (!en.isIntersecting) return;
          en.target.classList.add("is-in");
          io.unobserve(en.target);
        }),
      { threshold: 0.12, rootMargin: "0px 0px -8% 0px" }
    );
    $$(".reveal").forEach((el) => io.observe(el));
  } else {
    $$(".reveal").forEach((el) => el.classList.add("is-in"));
  }

  // Nav: shrink on scroll + active-section indicator
  const nav = $("#nav");
  const indicator = $(".nav__indicator");
  const navLinks = $$("[data-nav]");
  let active = null;

  const moveIndicator = () => {
    const link = $(`.nav__links a[data-nav="${active}"]`);
    if (!link) { indicator.style.opacity = "0"; return; }
    indicator.style.width = `${link.offsetWidth}px`;
    indicator.style.transform = `translateX(${link.parentElement.offsetLeft}px)`;
    indicator.style.opacity = "1";
  };
  const setActive = (id) => {
    if (id === active) return;
    active = id;
    navLinks.forEach((a) => (a.dataset.nav === id ? a.setAttribute("aria-current", "true") : a.removeAttribute("aria-current")));
    moveIndicator();
  };
  const sectionIO = new IntersectionObserver(
    (entries) => entries.forEach((en) => en.isIntersecting && setActive(en.target.id)),
    { rootMargin: "-45% 0px -50% 0px" }
  );
  ["top", "stack", "work", "experience", "about", "contact"].forEach((id) => {
    const el = document.getElementById(id);
    if (el) sectionIO.observe(el);
  });
  addEventListener("resize", moveIndicator, { passive: true });
  nav.addEventListener("transitionend", moveIndicator);
  document.fonts?.ready.then(moveIndicator);

  // Timeline glow line progress
  const timeline = $("#timeline");
  const tlItems = $$(".tl", timeline);
  const updateTimeline = () => {
    const vh = innerHeight;
    const r = timeline.getBoundingClientRect();
    const p = Math.min(1, Math.max(0, (vh * 0.6 - r.top) / r.height));
    timeline.style.setProperty("--p", p.toFixed(4));
    tlItems.forEach((li) => li.classList.toggle("is-lit", li.getBoundingClientRect().top + 30 < vh * 0.6));
  };

  let ticking = false;
  const onScroll = () => {
    if (ticking) return;
    ticking = true;
    requestAnimationFrame(() => {
      nav.classList.toggle("is-scrolled", scrollY > 24);
      updateTimeline();
      ticking = false;
    });
  };
  addEventListener("scroll", onScroll, { passive: true });
  onScroll();

  // Impact numbers count up when they scroll into view
  if (!reduceMotion && "IntersectionObserver" in window) {
    const countIO = new IntersectionObserver((entries) =>
      entries.forEach((en) => {
        if (!en.isIntersecting) return;
        countIO.unobserve(en.target);
        const el = en.target;
        const end = parseFloat(el.dataset.count.replace(/,/g, ""));
        if (!Number.isFinite(end)) return;
        const t0 = performance.now();
        const tick = (t) => {
          const k = Math.min(1, (t - t0) / 1400);
          el.textContent = Math.round(end * (1 - Math.pow(1 - k, 3))).toLocaleString();
          if (k < 1) requestAnimationFrame(tick);
        };
        requestAnimationFrame(tick);
      }), { threshold: 0.6 });
    $$("[data-count]").forEach((el) => countIO.observe(el));
  }

  if (reduceMotion || !finePointer) return; // pointer effects are desktop-only

  // Magnetic buttons
  $$(".magnetic").forEach((el) => {
    el.addEventListener("pointermove", (e) => {
      const r = el.getBoundingClientRect();
      const x = e.clientX - (r.left + r.width / 2);
      const y = e.clientY - (r.top + r.height / 2);
      el.style.transform = `translate(${x * 0.22}px, ${y * 0.32}px)`;
    });
    el.addEventListener("pointerleave", () => (el.style.transform = ""));
  });

  // 3D tilt + inner glow on project cards
  $$("[data-tilt]").forEach((card) => {
    card.addEventListener("pointerenter", () => card.classList.add("is-tilting"));
    card.addEventListener("pointermove", (e) => {
      const r = card.getBoundingClientRect();
      const px = (e.clientX - r.left) / r.width;
      const py = (e.clientY - r.top) / r.height;
      const max = card.classList.contains("card--featured") ? 3 : 6;
      card.style.setProperty("--ry", `${(px - 0.5) * max * 2}deg`);
      card.style.setProperty("--rx", `${(0.5 - py) * max * 2}deg`);
      card.style.setProperty("--mx", `${px * 100}%`);
      card.style.setProperty("--my", `${py * 100}%`);
    });
    card.addEventListener("pointerleave", () => {
      card.classList.remove("is-tilting");
      card.style.setProperty("--rx", "0deg");
      card.style.setProperty("--ry", "0deg");
    });
  });


  // Cursor glow (eased)
  const glow = $(".cursor-glow");
  let gx = innerWidth / 2, gy = innerHeight / 2, tx = gx, ty = gy, raf = 0;
  const loop = () => {
    gx += (tx - gx) * 0.14;
    gy += (ty - gy) * 0.14;
    glow.style.transform = `translate3d(${gx}px, ${gy}px, 0)`;
    raf = Math.abs(tx - gx) + Math.abs(ty - gy) > 0.5 ? requestAnimationFrame(loop) : 0;
  };
  addEventListener("pointermove", (e) => {
    tx = e.clientX;
    ty = e.clientY;
    glow.classList.add("on");
    if (!raf) raf = requestAnimationFrame(loop);
  }, { passive: true });
  document.addEventListener("pointerleave", () => glow.classList.remove("on"));
})();
