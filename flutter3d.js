// Interactive 3D Flutter logo for the About section.
// three.js is fetched only when the section nears the viewport; until then (or if
// WebGL is unavailable) the flat SVG fallback rendered by main.js stays visible.

const THREE_URL = "https://cdn.jsdelivr.net/npm/three@0.160.0/build/three.module.min.js";
const host = document.getElementById("scene3d");

if (host) {
  const io = new IntersectionObserver(
    (entries) => {
      if (!entries.some((e) => e.isIntersecting)) return;
      io.disconnect();
      import(THREE_URL).then(init).catch(() => {});
    },
    { rootMargin: "400px 0px" }
  );
  io.observe(host);
}

function init(THREE) {
  const reduceMotion = matchMedia("(prefers-reduced-motion: reduce)").matches;

  let renderer;
  try {
    renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true, powerPreference: "low-power" });
  } catch {
    return; // no WebGL: keep the SVG fallback
  }
  renderer.setPixelRatio(Math.min(devicePixelRatio, 2));
  renderer.outputColorSpace = THREE.SRGBColorSpace;
  renderer.toneMapping = THREE.ACESFilmicToneMapping;
  host.appendChild(renderer.domElement);

  const scene = new THREE.Scene();
  const camera = new THREE.PerspectiveCamera(35, 0.8, 0.1, 100);
  camera.position.set(0, 0, 11);

  /* ---- Flutter logo: the three official shapes, extruded (SVG units, 24×24) ---- */
  const toShape = (points) => {
    const s = new THREE.Shape();
    points.forEach(([x, y], i) => (i ? s.lineTo(x - 12, 12 - y) : s.moveTo(x - 12, 12 - y)));
    s.closePath();
    return s;
  };
  const PARTS = [
    { points: [[14.314, 0], [2.3, 12], [6, 15.7], [21.684, 0.013]], color: 0x54c5f8 },
    { points: [[14.328, 11.072], [7.857, 17.53], [15.24, 17.532], [21.7, 11.072]], color: 0x54c5f8 },
    { points: [[7.857, 17.53], [14.327, 24], [21.7, 24], [15.24, 17.532]], color: 0x01579b },
  ];
  const DEPTH = 1.6;
  const logo = new THREE.Group();
  PARTS.forEach(({ points, color }) => {
    const geo = new THREE.ExtrudeGeometry(toShape(points), {
      depth: DEPTH,
      bevelEnabled: true,
      bevelThickness: 0.28,
      bevelSize: 0.2,
      bevelSegments: 5,
      curveSegments: 1,
    });
    geo.translate(0, 0, -DEPTH / 2);
    const mat = new THREE.MeshPhysicalMaterial({
      color,
      metalness: 0.2,
      roughness: 0.25,
      clearcoat: 1,
      clearcoatRoughness: 0.12,
      emissive: color,
      emissiveIntensity: 0.14,
    });
    logo.add(new THREE.Mesh(geo, mat));
  });
  logo.scale.setScalar(0.18);
  logo.position.x = 0.1;
  scene.add(logo);

  /* ---- orbit: a thin ring with drifting particles ---- */
  const orbit = new THREE.Group();
  orbit.rotation.set(1.18, 0.2, 0);
  const ring = new THREE.Mesh(
    new THREE.TorusGeometry(3.0, 0.012, 12, 200),
    new THREE.MeshBasicMaterial({ color: 0x7d87ff, transparent: true, opacity: 0.55 })
  );
  orbit.add(ring);
  const COUNT = 140;
  const pos = new Float32Array(COUNT * 3);
  for (let i = 0; i < COUNT; i++) {
    const a = (i / COUNT) * Math.PI * 2 + Math.random() * 0.2;
    const r = 3.0 + (Math.random() - 0.5) * 0.45;
    pos.set([Math.cos(a) * r, Math.sin(a) * r, (Math.random() - 0.5) * 0.3], i * 3);
  }
  const dotsGeo = new THREE.BufferGeometry();
  dotsGeo.setAttribute("position", new THREE.BufferAttribute(pos, 3));
  orbit.add(
    new THREE.Points(
      dotsGeo,
      new THREE.PointsMaterial({ color: 0xa5b4fc, size: 0.06, transparent: true, opacity: 0.9, sizeAttenuation: true })
    )
  );
  scene.add(orbit);

  /* ---- lights ---- */
  scene.add(new THREE.AmbientLight(0xffffff, 0.45));
  const key = new THREE.DirectionalLight(0xffffff, 2.4);
  key.position.set(4, 6, 8);
  scene.add(key);
  const indigo = new THREE.PointLight(0x7d87ff, 40, 30);
  indigo.position.set(-5, -3, 5);
  scene.add(indigo);
  const rim = new THREE.PointLight(0x38bdf8, 50, 30);
  rim.position.set(5, 3, -5);
  scene.add(rim);

  /* ---- sizing ---- */
  const resize = () => {
    const w = host.clientWidth;
    const h = host.clientHeight;
    if (!w || !h) return;
    renderer.setSize(w, h, false);
    camera.aspect = w / h;
    // keep the logo framed on narrow/tall boxes
    camera.position.z = w / h < 0.75 ? 12.5 : 11;
    camera.updateProjectionMatrix();
    if (reduceMotion) renderer.render(scene, camera);
  };
  new ResizeObserver(resize).observe(host);
  resize();

  /* ---- pointer tilt ---- */
  const target = { x: 0, y: 0 };
  const tilt = { x: 0, y: 0 };
  if (!reduceMotion) {
    addEventListener(
      "pointermove",
      (e) => {
        const r = host.getBoundingClientRect();
        target.x = Math.max(-1, Math.min(1, (e.clientX - (r.left + r.width / 2)) / (r.width * 1.5)));
        target.y = Math.max(-1, Math.min(1, (e.clientY - (r.top + r.height / 2)) / (r.height * 1.5)));
      },
      { passive: true }
    );
  }

  /* ---- loop: runs only while visible ---- */
  let visible = true;
  let raf = 0;
  const clock = new THREE.Clock();
  const frame = () => {
    const t = clock.getElapsedTime();
    tilt.x += (target.x - tilt.x) * 0.06;
    tilt.y += (target.y - tilt.y) * 0.06;
    logo.rotation.y = Math.sin(t * 0.5) * 0.45 + tilt.x * 0.7;
    logo.rotation.x = Math.sin(t * 0.7) * 0.06 + tilt.y * 0.4;
    logo.position.y = Math.sin(t * 1.1) * 0.12;
    orbit.rotation.z = t * 0.12;
    renderer.render(scene, camera);
    raf = requestAnimationFrame(frame);
  };
  const play = () => {
    if (!raf && visible && !document.hidden) raf = requestAnimationFrame(frame);
  };
  const pause = () => {
    cancelAnimationFrame(raf);
    raf = 0;
  };

  if (reduceMotion) {
    logo.rotation.set(0.05, -0.35, 0);
    renderer.render(scene, camera);
  } else {
    new IntersectionObserver(([e]) => {
      visible = e.isIntersecting;
      visible ? play() : pause();
    }).observe(host);
    document.addEventListener("visibilitychange", () => (document.hidden ? pause() : play()));
    play();
  }

  requestAnimationFrame(() => host.classList.add("is-ready"));
}
