{ pkgs, ... }:
{
  home.homeDirectory = "/Users/mark";
  home.packages = with pkgs; [
    google-cloud-sdk
  ];
}
