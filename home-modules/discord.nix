{
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.nixcord = {
    enable = true;
    discord.enable = false;
    config.autoUpdate = true;
    vesktop = {
    #equibop = {
      enable = true;
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
        biggerStreamPreview.enable = true;
        BlurNSFW.enable = true;
        callTimer = {
          enable = true;
          format = "human";
        };
        ClearURLs.enable = true;
        CustomRPC.enable = true;
        fakeNitro.enable = true;
        friendsSince.enable = true;
        fullSearchContext.enable = true;
        greetStickerPicker.enable = true;
        implicitRelationships.enable = true;
        mentionAvatars.enable = true;
        MutualGroupDMs.enable = true;
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
        youtubeAdblock.enable = true;
      };
    };
    #equibopConfig = {
      #plugins = {
        #alwaysAnimate.enable = true;
        #anonymiseFileNames = {
          #enable = true;
          #anonymiseByDefault = false;
        #};
        #betterFolders = {
          #enable = true;
          #sidebar = false;
          #closeAllFolders = true;
          #closeAllHomeButton = true;
          #closeOthers = true;
          #forceOpen = true;
        #};
        #betterGifAltText.enable = true;
        #betterGifPicker.enable = true;
        #betterInvites.enable = true;
        #biggerStreamPreview.enable = true;
        #blurNsfw.enable = true;
        #callTimer = {
          #enable = true;
          #format = "human";
        #};
        #characterCounter.enable = true;
        #clearUrLs.enable = true;
        #customRpc.enable = true;
        #fakeNitro.enable = true;
        #friendsSince.enable = true;
        #fullSearchContext.enable = true;
        #greetStickerPicker.enable = true;
        #implicitRelationships.enable = true;
        #mentionAvatars.enable = true;
        #moreKaomoji.enable = true;
        #mutualGroupDMs.enable = true;
        #noF1.enable = true;
        #noReplyMention = {
          #enable = true;
          #inverseShiftReply = true;
        #};
        #previewMessage.enable = true;
        #readAllNotificationsButton.enable = true;
        #sendTimestamps.enable = true;
        #silentTyping.enable = true;
        #typingIndicator.enable = true;
        #typingTweaks.enable = true;
        #viewIcons.enable = true;
        #viewRaw.enable = true;
        #volumeBooster.enable = true;
        #whoReacted.enable = true;
        #whosWatching.enable = true;
        #youtubeAdblock.enable = true;
      #};
    #};
  };
}
