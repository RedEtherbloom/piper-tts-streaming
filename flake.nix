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
        self',
        ...
      }: {
        packages = rec {
          piper-tts-streaming = pkgs.buildGoModule (finalAttrs: {
            pname = "piper-tts-streaming";
            # TODO: Can this be automatically pulled from the go files?
            version = "0.0.1";

            # TODO: Fill in correct folder
            src = ./src;
            vendorHash = null;
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
          });
          default = piper-tts-streaming;
        };
      };
    };
}
