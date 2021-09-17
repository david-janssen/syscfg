{ config, lib, pkgs, ... }:

let
  pyFile = builtins.readFile ./offlineimap.py;
in

{

  accounts.email.maildirBasePath = "dcs/mail";

  programs = {

    offlineimap = {
      enable = true;
      pythonFile = pyFile;
      extraConfig.general.maxage = 30;
    };

    msmtp.enable = true;
  };

  # janssen.dhj@gmail.com ------------------------------------------------------

  accounts.email.accounts."gmail" = {
    primary = true;
    flavor  = "gmail.com";
    passwordCommand = "pass web/gmail";
    maildir.path = "gmail";

    address = "janssen.dhj@gmail.com";
    userName = "janssen.dhj@gmail.com";
    realName = "David Janssen";

    folders = {
      drafts = "drafts";
      inbox  = "inbox";
      sent   = "sent";
      trash  = "trash";
    };

    msmtp.enable = true;
    offlineimap = {
      enable = true;
      extraConfig = {
        account = {
          # Extra config for account section
          quick = 10;
          autorefresh = 5;
          synclabels = "yes";
        };
        local = {
          # Extra config for local section
          sync_deletes = false;
        };
        remote = {
          # Extra config for remote section
          expunge = false;
          trashfolder = "[Gmail]/Trash";
          maxconnections = 2;
          folderfilter = "include_p_gmail";
          nametrans    = "nametrans_gmail";
        };
      };
      postSyncHookCommand = "mu index";
    };
  };
}
