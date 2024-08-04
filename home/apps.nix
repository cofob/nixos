{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [ chromium ];

  programs.firefox = {
    enable = true;
    # profiles = {
    #   default = {
    #     isDefault = true;
    #     userChrome = ''
    #       #TabsToolbar
    #       {
    #           visibility: collapse;
    #       }
    #     '';
    #     settings = {
    #       # Disable "about:config" warn
    #       "browser.aboutConfig.showWarning" = false;

    #       # Remove import bookmarks button and remove default bookmarks
    #       "browser.bookmarks.restore_default_bookmarks" = false;
    #       "browser.bookmarks.addedImportButton" = true;
    #       # Disable top bookmarks
    #       "browser.toolbars.bookmarks.visibility" = "never";

    #       # Overwrite welcome page
    #       "startup.homepage_welcome_url" = "https://nixos.org";

    #       # Disable auto update
    #       "app.update.checkInstallTime" = false;
    #       "app.update.auto" = false;

    #       # Strict protection
    #       "browser.contentblocking.category" = "strict";

    #       # Disable login saving
    #       "signon.management.page.breach-alerts.enabled" = false;
    #       "signon.rememberSignons" = false;

    #       "browser.startup.homepage" = "https://duckduckgo.com/";
    #       "general.useragent.locale" = "en-US";
    #       "browser.search.region" = "RU";
    #       "browser.search.isUS" = false;

    #       # Set theme
    #       "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

    #       # I2P, tor TLD's
    #       "browser.fixup.domainsuffixwhitelist.onion" = true;
    #       "browser.fixup.domainsuffixwhitelist.i2p" = true;

    #       # Disable sponsored sites (Amazon and similar shit)
    #       "browser.newtabpage.activity-stream.showSponsored" = false;
    #       "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

    #       # Set download dir
    #       "browser.download.lastDir" = "/home/cofob/Downloads";

    #       # Browser UI customization
    #       "browser.uiCustomization.state" = ''
    #         {"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["_3c078156-979c-498b-8990-85f7987dd929_-browser-action","sponsorblocker_ajay_app-browser-action","jid1-mnnxcxisbpnsxq_jetpack-browser-action","ipfs-firefox-addon_lidel_org-browser-action","jid1-kkzogwgsw3ao4q_jetpack-browser-action","foxyproxy_eric_h_jung-browser-action","jid1-bofifl9vbdl2zq_jetpack-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action","adnauseam_rednoise_org-browser-action","addon_darkreader_org-browser-action","_290ce447-2abb-4d96-8384-7256dd4a1c43_-browser-action","jid1-aqqsmbyb0a8adg_jetpack-browser-action","_b7f0a607-9c0a-46dc-86ad-e2e1a883b25c_-browser-action","jid1-5fs7itlscuazbgwr_jetpack-browser-action","webextension_metamask_io-browser-action","_5799d9b6-8343-4c26-9ab6-5d2ad39884ce_-browser-action","tab-stash_condordes_net-browser-action","_testpilot-containers-browser-action","treestyletab_piro_sakura_ne_jp-browser-action","_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","urlbar-container","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","reset-pbm-toolbar-button","_c2c003ee-bd69-42a2-b0e9-6f34222cb046_-browser-action","unified-extensions-button","downloads-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["firefox-view-button","tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","adnauseam_rednoise_org-browser-action","_c2c003ee-bd69-42a2-b0e9-6f34222cb046_-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action","jid1-bofifl9vbdl2zq_jetpack-browser-action","foxyproxy_eric_h_jung-browser-action","jid1-kkzogwgsw3ao4q_jetpack-browser-action","ipfs-firefox-addon_lidel_org-browser-action","jid1-mnnxcxisbpnsxq_jetpack-browser-action","addon_darkreader_org-browser-action","_290ce447-2abb-4d96-8384-7256dd4a1c43_-browser-action","jid1-aqqsmbyb0a8adg_jetpack-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","_b7f0a607-9c0a-46dc-86ad-e2e1a883b25c_-browser-action","jid1-5fs7itlscuazbgwr_jetpack-browser-action","_5799d9b6-8343-4c26-9ab6-5d2ad39884ce_-browser-action","webextension_metamask_io-browser-action","tab-stash_condordes_net-browser-action","_testpilot-containers-browser-action","treestyletab_piro_sakura_ne_jp-browser-action","_3c078156-979c-498b-8990-85f7987dd929_-browser-action","_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action","sponsorblocker_ajay_app-browser-action"],"dirtyAreaCache":["nav-bar","toolbar-menubar","TabsToolbar","PersonalToolbar","widget-overflow-fixed-list","unified-extensions-area"],"currentVersion":20,"newElementCount":9}'';

    #       "devtools.everOpened" = true;

    #       # HTTPS-only
    #       "dom.security.https_only_mode" = true;

    #       # Yggdrasil tweaks
    #       "network.http.fast-fallback-to-IPv4" = false;
    #       "browser.fixup.fallback-to-https" = false;
    #       "browser.fixup.alternate.enabled" = false;
    #       "network.dns.disableIPv6" = false;

    #       # Enable userChrome.css
    #       "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

    #       # telemetry
    #       "browser.newtabpage.activity-stream.feeds.telemetry" = false;
    #       "browser.newtabpage.activity-stream.telemetry" = false;
    #       "toolkit.telemetry.shutdownPingSender.enabled" = false;
    #       "toolkit.telemetry.firstShutdownPing.enabled" = false;
    #       "toolkit.telemetry.reportingpolicy.firstRun" = false;
    #       "datareporting.policy.dataSubmissionEnabled" = false;
    #       "toolkit.telemetry.newProfilePing.enabled" = false;
    #       "datareporting.healthreport.uploadEnabled" = false;
    #       "toolkit.telemetry.hybridContent.enabled" = false;
    #       "devtools.onboarding.telemetry.logged" = false;
    #       "toolkit.telemetry.updatePing.enabled" = false;
    #       "datareporting.sessions.current.clean" = true;
    #       "toolkit.telemetry.bhrPing.enabled" = false;
    #       "toolkit.telemetry.archive.enabled" = false;
    #       "browser.ping-centre.telemetry" = false;
    #       "toolkit.telemetry.server_owner" = "";
    #       "toolkit.telemetry.enabled" = false;
    #       "toolkit.telemetry.unified" = false;
    #       "toolkit.telemetry.server" = "";
    #     };
    #   };
    # };
  };
}
