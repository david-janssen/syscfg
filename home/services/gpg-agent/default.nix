{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 3600;
    defaultCacheTtlSsh = 3600;
    maxCacheTtl = 3600;
    maxCacheTtlSsh = 3600;
    pinentryFlavor = "gtk2";
    extraConfig = ''
      allow-loopback-binentry
    '';
  };
}
