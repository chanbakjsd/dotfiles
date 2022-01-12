pkgs: 

let
	discord-version = "0.0.132";
	discord-hash = "1jjbd9qllgcdpnfxg5alxpwl050vzg13rh17n638wha0vv4mjhyv";
	node-coc-spell-checker = import ./coc-spell-checker { inherit pkgs; };
	node-coc-svelte = import ./coc-svelte { inherit pkgs; };
in
{
	discord-canary = pkgs.discord-canary.overrideAttrs (ori: {
		version = "0.0.131";
		src = builtins.fetchurl {
			url = "https://dl-canary.discordapp.net/apps/linux/${discord-version}/discord-canary-${discord-version}.tar.gz";
			sha256 = discord-hash;
		};
	});
	os-prober = pkgs.os-prober.overrideAttrs (ori: {
		patches = [ ./os-prober.patch ]; # OS Prober is awfully slow in detecting Linux distros.
	});
	vimPlugins = pkgs.lib.recursiveUpdate pkgs.vimPlugins {
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
