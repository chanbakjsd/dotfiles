{ nixpkgs, ... }:
{ config, pkgs, ... }:

let
	pkgPath = nixpkgs.outPath;
in
{
	imports = [
		"${pkgPath}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
		"${pkgPath}/nixos/modules/installer/cd-dvd/channel.nix"
	];

	boot.kernelPackages = pkgs.zfs.latestCompatibleLinuxPackages;

	nix.package = pkgs.nixUnstable;
	nix.extraOptions = "experimental-features = nix-command flakes";
}
