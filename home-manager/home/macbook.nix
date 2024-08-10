{ pkgs, ... }:
{
  home = {
    homeDirectory = "/Users/mark";
    sessionPath = [ "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ];
    packages = with pkgs; [
      google-cloud-sdk
      ngrok
    ];
  };
}
