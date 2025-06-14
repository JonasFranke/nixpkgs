{
  lib,
  fetchFromGitHub,

  fetchYarnDeps,
  npmHooks,
  nodejs,

  rustPlatform,
  cargo-tauri_1,

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
    hash = "";
  };

  forceGitDeps = true;

  makeCacheWritable = true;

  cargoRoot = "src-tauri";

  useFetchCargoVendor = true;
  cargoHash = "";

  buildAndTestSubdir = cargoRoot;

  nativeBuildInputs = [
    npmHooks.npmConfigHook
    nodejs

    cargo-tauri_1.hook

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
