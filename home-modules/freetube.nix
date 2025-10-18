{...}: {
  programs.freetube = {
    enable = true;
    settings = {
      # General Settings
      checkForUpdates = false;
      checkForBlogPosts = false;

      # Distraction Free Settings
      ## Side Bar
      hideTrendingVideos = true;
      hidePopularVideos = true;

      ## Subscriptions Page
      hideSubscriptionsLive = true;
      hideSubscriptionsShorts = true;
      hideSubscriptionsCommunity = false;

      ## Watch Page
      hideVideoLikesAndDislikes = false;
      hideLiveChat = true;
      hideRecommendedVideos = true;
      hideComments = false;

      ## General
      hideVideoViews = false;
      hideChannelSubscriptions = false;

      # Download Settings
      downloadBehavior = "download";

      # SponsorBlock Settings
      useSponsorBlock = true;
      useDeArrowTitles = true;
      useDeArrowThumbnails = true;
    };
  };
}
