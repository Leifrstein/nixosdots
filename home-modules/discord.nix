{config, inputs, ...}: {
  programs.nixcord = {
    enable = true;
    discord.enable = false;
    config.autoUpdate = true;
    equibop = {
      enable = true;
      # TODO: remove when fixed
      # Apply Vesktop read-only state patch
      package = pkgs.equibop.overrideAttrs (oldAttrs: {
        patches = (oldAttrs.patches or [ ]) ++ [
          "${inputs.nixpkgs}/pkgs/by-name/ve/vesktop/fix_read_only_settings.patch"
        ];
      });
      settings = {
        discordBranch = "stable";
        staticTitle = true;
        splashTheming = true;
        enableSplashScreen = false;
        minimizeToTray = true;
        clickTrayToShowHide = true;
        arRPC = true;
        splashProgress = true;
      };
      state = {
        firstLaunch = false;
      };
    };
    config = {
      themeLinks = [
        "https://raw.githubusercontent.com/catppuccin/discord/refs/heads/main/themes/${config.catppuccin.flavor}.theme.css"
      ];
      enabledThemes = [
        "${config.catppuccin.flavor}.theme.css"
      ];
    };
    equibopConfig = {
      plugins = {
        alwaysAnimate.enable = true;
        anonymiseFileNames = {
          enable = true;
          anonymiseByDefault = false;
        };
        betterFolders = {
          enable = true;
          sidebar = false;
          closeAllFolders = true;
          closeAllHomeButton = true;
          closeOthers = true;
          forceOpen = true;
        };
        betterGifAltText.enable = true;
        betterGifPicker.enable = true;
        betterInvites.enable = true;
        biggerStreamPreview.enable = true;
        blurNsfw.enable = true;
        callTimer = {
          enable = true;
          format = "human";
        };
        characterCounter.enable = true;
        clearUrLs.enable = true;
        customRpc.enable = true;
        fakeNitro.enable = true;
        friendsSince.enable = true;
        fullSearchContext.enable = true;
        greetStickerPicker.enable = true;
        implicitRelationships.enable = true;
        mentionAvatars.enable = true;
        moreKaomoji.enable = true;
        mutualGroupDMs.enable = true;
        noF1.enable = true;
        noReplyMention = {
          enable = true;
          inverseShiftReply = true;
        };
        previewMessage.enable = true;
        readAllNotificationsButton.enable = true;
        sendTimestamps.enable = true;
        silentTyping.enable = true;
        typingIndicator.enable = true;
        typingTweaks.enable = true;
        viewIcons.enable = true;
        viewRaw.enable = true;
        volumeBooster.enable = true;
        whoReacted.enable = true;
        whosWatching.enable = true;
        youtubeAdblock.enable = true;
      };
    };
  };
}
