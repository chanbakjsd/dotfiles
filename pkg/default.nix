pkgs:

let
	swaylock-version = "a8fc557b86e70f2f7a30ca9ff9b3124f89e7f204";
	node-coc-spell-checker = import ./coc-spell-checker { inherit pkgs; };
	node-coc-gunk = import ./coc-gunk { inherit pkgs; };
	node-coc-svelte = import ./coc-svelte { inherit pkgs; };
in
{
	swaylock-effects = pkgs.swaylock-effects.overrideAttrs (ori: {
		version = swaylock-version;
		src = pkgs.fetchFromGitHub {
			owner = "mortie";
			repo = "swaylock-effects";
			rev = swaylock-version;
			sha256 = "sha256-GN+cxzC11Dk1nN9wVWIyv+rCrg4yaHnCePRYS1c4JTk=";
		};
	});
	os-prober = pkgs.os-prober.overrideAttrs (ori: {
		patches = [ ./os-prober.patch ]; # OS Prober is awfully slow in detecting Linux distros.
	});
	vimPlugins = pkgs.lib.recursiveUpdate pkgs.vimPlugins {
		coc-gunk = pkgs.vimUtils.buildVimPlugin {
			name = "coc-gunk";
			src = "${node-coc-gunk.coc-gunk}/lib/node_modules/coc-gunk";
		};
		coc-spell-checker = pkgs.vimUtils.buildVimPlugin {
			name = "coc-spell-checker";
			src = "${node-coc-spell-checker.coc-spell-checker}/lib/node_modules/coc-spell-checker";
		};
		coc-svelte = pkgs.vimUtils.buildVimPlugin {
			name = "coc-svelte";
			src = "${node-coc-svelte.coc-svelte}/lib/node_modules/coc-svelte";
		};
	};
}
