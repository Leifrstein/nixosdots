{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.firefox = let
    inherit (pkgs.nur.repos.rycee) firefox-addons;
    catppuccin-firefox = firefox-addons.buildFirefoxXpiAddon {
      pname = "catppuccin-firefox";
      version = "old";
      url = "https://github.com/catppuccin/firefox/releases/download/old/catppuccin_${config.catppuccin.flavor}_${config.catppuccin.accent}.xpi";
      sha256 = "sha256-pSlzVe7XbTbrC76iAinYrr7qIl69OpH3Wk00MoAIe74=";
      addonId = "{76aabc99-c1a8-4c1e-832b-d4f2941d5a7a}";
      meta = {};
    };
  in {
    enable = true;
    package = pkgs.firefox.override {
      # Set preferences here to ensure they stay set
      extraPrefs =
        # javascript
        ''
          // Only sync bookmarks and tabs
          // Some of these are set by default, but they should be locked just in case
          lockPref("services.sync.engine.bookmarks", true)
          lockPref("services.sync.engine.tabs", true)
          lockPref("services.sync.engine.addons", false);
          lockPref("services.sync.engine.addresses", false);
          lockPref("services.sync.engine.addresses.available", false);
          lockPref("services.sync.engine.creditcards", false);
          lockPref("services.sync.engine.creditcards.available", false);
          lockPref("services.sync.engine.history", false);
          lockPref("services.sync.engine.passwords", false);
          lockPref("services.sync.engine.prefs", false);
          // Enable sync
          lockPref("identity.fxaccounts.enabled", true);
          // Automatically enable installed extensions
          lockPref("extensions.autoDisableScopes", 0);
          // Set theme
          lockPref("extensions.activeThemeID", "${catppuccin-firefox.addonId}");
          // Use same search engine for private browsing
          lockPref("browser.search.separatePrivateDefault", false);
          // Set what to clear on shutdown
          lockPref("privacy.clearOnShutdown.history", false);
          lockPref("privacy.clearOnShutdown_v2.historyFormDataAndDownloads", false);
          lockPref("privacy.clearOnShutdown.cookies", false);
          lockPref("network.cookie.lifetimePolicy", 0);
        '';
    };
    profiles = {
      # Separate profile to enable WebGL because it allows more fingerprinting
      gaming = {
        id = 1;
        # Un-break certain websites
        settings."webgl.disabled" = false;
        extensions = {
          packages = with firefox-addons; [
            canvasblocker # Recommended for enabled WebGL
            bitwarden
          ];
          force = true;
        };
      };
      default = {
        extensions = {
          # Override extension settings
          # NOTE: Each extension also needs `force = true` to prevent file conflicts
          force = true;
          packages = with firefox-addons; [
            awesome-rss
            catppuccin-firefox
            catppuccin-web-file-icons
            darkreader
            indie-wiki-buddy
            bitwarden
            redirector
            stylus
            buster-captcha-solver
            fastforwardteam
            istilldontcareaboutcookies
            violentmonkey
            reddit-enhancement-suite
            # Reminder to install xBrowserSync, can't be done declaratively to my knowledge
            ublock-origin
            ublacklist
          ];
          settings = let
            fonts = config.stylix.fonts;
            accent = config.catppuccin.accent;
            palette =
              (lib.importJSON "${config.catppuccin.sources.palette}/palette.json")
              .${config.catppuccin.flavor}
              .colors;
          in {
            # Turn off google safebrowsing
						"browser.safebrowsing.downloads.remote.block_dangerous" = false;
						"browser.safebrowsing.downloads.remote.block_dangerous_host" = false;
						"browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
						"browser.safebrowsing.downloads.remote.block_uncommon" = false;
						"browser.safebrowsing.downloads.remote.url" = false;
						"browser.safebrowsing.downloads.remote.enabled" = false;
						"browser.safebrowsing.downloads.enabled" = false;
            
            # Turn off telemetry
						"toolkit.telemetry.enabled" = false;
						"toolkit.telemetry.unified" = false;
						"toolkit.telemetry.archive.enabled" = false;
						"datareporting.healthreport.uploadEnabled" = false;
						"datareporting.healthreport.service.enabled" = false;
						"datareporting.policy.dataSubmissionEnabled" = false;
						
						# Turn off experimental features
						"experiments.supported" = false;
						"experiments.enabled" = false;
						"experiments.manifest.uri" = "";
						"browser.discovery.enabled" = false;
						"extensions.shield-recipe-client.enabled" = false;
						#"app.shield.optoutstudies.enabled" = false;
						"loop.logDomains" = false;
						
						# Hide top stories
						"browser.newtabpage.activity-stream.feeds.section.topstories" = false;
						
						# Cookie policy - 0 accepts all cookies, 1 blocks all 3rd-party cookies, 2 blocks all cookies
						"network.cookie.cookieBehavior" = 1;
						
						# Disable default browser check
						"browser.shell.checkDefaultBrowser" = false;
						
						# Force-enable GPU rendering
						"gfx.webrender.all" = true;
						
						# Enable hw video decoding and sandbox it
						"media.ffmpeg.vaapi.enabled" = true;
						"media.rdd-ffmpeg.enabled" = true;
						
						# Disable old encoders
						"media.ffvpx.enabled" = false;
						"media.navigator.mediadatadecoder_vpx_enabled" = true;
						"media.rdd-vpx.enabled" = false;
						
						# Disable clipboard api
						"dom.event.clipboardevents.enabled" = false;
            
            "addon@darkreader.org" = {
              force = true;
              settings = {
                syncSettings = false;
                theme = {
                  fontFamily = fonts.sansSerif.name;
                  darkSchemeBackgroundColor = palette.base.hex;
                  darkSchemeTextColor = palette.text.hex;
                  selectionColor = palette.surface2.hex;
                };
                previewNewDesign = true;
              };
            };

            # Stylus
            "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" = {
              force = true;
              settings = {
                dbInChromeStorage = true; # required for Stylus
              };
            };

            "@ublacklist" = {
              force = true;
              settings = {
                subscriptions = {
                  "0" = {
                    name = "Main AI blocklist";
                    url = "https://raw.githubusercontent.com/laylavish/uBlockOrigin-HUGE-AI-Blocklist/main/list_uBlacklist.txt";
                  };
                };
                updateInterval = 60;
                linkColor = palette.blue.hex;
                blockColor = palette.red.hex;
                highlightColors = [palette.${accent}.hex];
              };
            };
          };
        };
        search = let
          mkParams = lib.mapAttrsToList lib.nameValuePair;
        in {
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = mkParams {
                    channel = "unstable";
                    type = "packages";
                    query = "{searchTerms}";
                  };
                }
              ];
              icon = "https://search.nixos.org/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@np"];
            };

            "NixOS Wiki" = {
              urls = [
                {
                  template = "https://wiki.nixos.org/index.php";
                  params = mkParams {
                    search = "{searchTerms}";
                  };
                }
              ];
              icon = "https://wiki.nixos.org/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@nw"];
            };

            "Nix Home Manager" = {
              urls = [
                {
                  template = "https://home-manager-options.extranix.com/";
                  params = mkParams {
                    query = "{searchTerms}";
                    release = "master";
                  };
                }
              ];
              icon = "https://home-manager-options.extranix.com/images/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@nhm"];
            };

            "bing".metaData.hidden = true;
            "google".metaData.hidden = true;
            "wikipedia".metaData.alias = "@w";
          };
          force = true;
          default = "ddg";
        };
      };
    };
  };
}
