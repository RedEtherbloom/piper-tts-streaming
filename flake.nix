{
  description = "Publish a REST API to keep piper loaded in-between invocations.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      perSystem = {
        pkgs,
        ...
      }: {
        packages = rec {
          piper-tts-streaming = pkgs.buildGoModule {
            pname = "piper-tts-streaming";
            version = "0.0.2";

            src = ./.;
            vendorHash = "sha256-39n1qCvAeQJeYmGPII8/D3xprRYFTM2Epg3JWzu1hZQ=";
            meta = {
              description = "Publish a REST API to keep piper loaded in-between invocations.";
              homepage = "https://github.com/RedEtherbloom/piper-tts-streaming";
              license = pkgs.lib.licenses.mit;
              maintainers = [
                {
                  email = "etherbloom+github@mailbox.org";
                  github = "RedEtherbloom";
                  githubId = 16244495;
                  name = "Etherbloom";
                }
              ];
            };
          };
          default = piper-tts-streaming;
        };
      };
    };
}
