{ pkgs, ... }:
{
  home.homeDirectory = "/home/mark";
  home.packages = with pkgs; [
  ];
}
