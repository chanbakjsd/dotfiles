pkgs: 

let
	node-coc-spell-checker = import ./coc-spell-checker { inherit pkgs; };
in
{
	os-prober = pkgs.os-prober.overrideAttrs (ori: {
		patches = [ ./os-prober.patch ]; # OS Prober is awfully slow in detecting Linux distros.
	});
	vimPlugins = pkgs.lib.recursiveUpdate pkgs.vimPlugins {
		coc-spell-checker = pkgs.vimUtils.buildVimPlugin {
			name = "coc-spell-checker";
			src = "${node-coc-spell-checker.coc-spell-checker}/lib/node_modules/coc-spell-checker";
		};
	};
}
