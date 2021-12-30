{ pkgs, ...}:
{
	programs.git = {
		enable = true;
		signing = {
			key = "7E9A74B1B07A7558";
			signByDefault = true;
		};
		userEmail = "lutherchanpublic@gmail.com";
		userName = "Chan Wen Xu";
		extraConfig = {
			core = {
				excludesfile = "${pkgs.writeText "gitignore" (
					builtins.concatStringsSep "\n" [
						".direnv"
						".envrc"
						"default.nix"
					]
				)}";
			};
		};
	};
}
