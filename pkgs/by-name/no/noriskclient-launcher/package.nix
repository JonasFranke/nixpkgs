{
  lib,
  fetchFromGitHub,

  fetchYarnDeps,
  yarnHooks,
  nodejs,
  yarn,
  typescript,
  vite,

  rustPlatform,
  cargo-tauri,

  pkg-config,
  wrapGAppsHook3,

  openssl,
  libsoup_2_4,
  webkitgtk_4_0,
  glib-networking,
}:

rustPlatform.buildRustPackage rec {
  pname = "noriskclient-launcher";
  version = "0.6.1";

  src = fetchFromGitHub {
    owner = "NoRiskClient";
    repo = "noriskclient-launcher";
    rev = "refs/tags/v${version}";
    hash = "sha256-0QiTU9IET10FFXFuDP00ItWaoa3KjtiuTum53LTHLEY=";
  };

  yarnDeps = fetchYarnDeps {
    name = "${pname}-${version}-yarn-deps";
    inherit src;
    hash = "sha256-MEdT/1jPtt9PIMGzBaiji67UUqwDi+vF//w9cAvtOBk=";
  };

  forceGitDeps = true;

  makeCacheWritable = true;

  cargoRoot = "src-tauri";

  useFetchCargoVendor = true;
  cargoHash = "sha256-qKkRjYe/uPf9V/4QgMRSCu9u2G4Ghxe4meGxkuodkns=";

  buildAndTestSubdir = cargoRoot;

  nativeBuildInputs = [
    nodejs
    yarn
    typescript
    vite

    yarnHooks.yarnConfigHook

    cargo-tauri.hook

    pkg-config
    wrapGAppsHook3
  ];

  buildInputs = [
    openssl
    libsoup_2_4
    webkitgtk_4_0
    glib-networking
  ];

  meta = {
    description = "Minecraft client application made using svelte + tauri";
    homepage = "https://norisk.gg";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ genga898 ];
    mainProgram = "no-risk-client";
  };
}
