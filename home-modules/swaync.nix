{...}: {
  #services.swaync = {
    #enable = true;
    #settings = {
      #positionX = "right";
      #positionY = "top";
      #layer = "overlay";
      #control-center-layer = "top";
      #layer-shell = true;
      #cssPriority = "user";
      #control-center-margin-top = 5;
      #control-center-margin-bottom = 0;
      #control-center-margin-right = 0;
      #control-center-margin-left = 0;
      #notification-2fa-action = true;
      #notification-inline-replies = false;
      #notification-icon-size = 24;
      #notification-body-image-height = 100;
      #notification-body-image-width = 200;
      #timeout = 6;
      #timeout-low = 3;
      #timeout-critical = 0;
      #fit-to-screen = false;
      #control-center-width = 400;
      #control-center-height = 720;
      #notification-window-width = 400;
      #keyboard-shortcuts = true;
      #transition-time = 200;
      #hide-on-clear = false;
      #hide-on-action = true;
      #script-fail-notify = true;
      #widgets = [
        #"dnd"
        #"mpris"
        #"title"
        #"notifications"
      #];
      #widget-config = {
        #title = {
          #text = "Notifications";
          #clear-all-button = true;
          #button-text = "Clear";
        #};
        #dnd = {
          #text = "Do Not Disturb";
        #};
        #label = {
          #max-lines = 1;
          #text = "Notification";
        #};
        #mpris = {
          #image-size = 10;
          #image-radius = 0;
        #};
      #};
    #};
    #style = ''
       #* {
       	#font-family: "Ubuntu Nerd Font";
       	#font-weight: bold;
       #}

       #.control-center .notification-row:focus,
       #.control-center .notification-row:hover {
       	#opacity: 1;
       	#background: #11111b;
       	#border-radius: 10px
       #}

       #.notification-row {
       	#outline: none;
       	#margin: 0px;
       #}

       #.notification {
       	#border-radius: 10px;
       #}

       #.notification-content {
       	#color: #cdd6f4;
       	#background: #1e1e2e;
       	#padding: 3px 10px 3px 6px;
       	#border-radius: 10px;
       	#border: 1px solid #cba6f7;
       	#margin: 0px;
       #}

       #.notification-default-action {
       	#margin: 0;
       	#padding: 0;
       	#border-radius: 10px;
       #}

       #.close-button {
       	#background: #f38ba8;
       	#color: #11111b;
       	#text-shadow: none;
       	#padding: 0;
       	#border-radius: 10px;
       	#margin-top: 5px;
       	#margin-right: 5px;
       #}

       #.close-button:hover {
       	#box-shadow: none;
       	#background: rgb(248, 145, 173);
       	#transition: all .15s ease-in-out;
       	#border: none
       #}


       #.notification-action {
       	#border: 1px solid #b4befe;
       	#border-top: none;
       	#border-radius: 10px;
       #}


       #.notification-default-action:hover,
       #.notification-action:hover {
       	#color: #cdd6f4;
       	#background: #1e1e2e;
       #}

       #.notification-default-action {
       	#border-radius: 10px;
       	#margin: 5px;
       #}

       #.notification-default-action:not(:only-child) {
       	#border-bottom-left-radius: 7px;
       	#border-bottom-right-radius: 7px
       #}

       #.notification-action:first-child {
       	#border-bottom-left-radius: 10px;
       	#background: #1e1e2e
       #}

       #.notification-action:last-child {
       	#border-bottom-right-radius: 10px;
       	#background: #1e1e2e
       #}

       #.inline-reply {
       	#margin-top: 8px
       #}

       #.inline-reply-entry {
       	#background: #1e1e2e;
       	#color: #cdd6f4;
       	#caret-color: #cdd6f4;
       	#border: 1px solid #b4befe;
       	#border-radius: 10px
       #}

       #.inline-reply-button {
       	#font-size: 0.5rem;
       	#margin-left: 4px;
       	#background: #1e1e2e;
       	#border: 1px solid #b4befe;
       	#border-radius: 10px;
       	#color: #cdd6f4;
       #}

       #.inline-reply-button:disabled {
       	#background: initial;
       	#color: #a6adc8;
       	#border: 1px solid transparent
       #}

       #.inline-reply-button:hover {
       	#background: #1e1e2e;
       #}

       #.body-image {
       	#margin-top: 6px;
       	#color: #cdd6f4;
       	#border-radius: 10px
       #}

       #.summary {
       	#font-size: 1rem;
       	#font-weight: bold;
       	#background: transparent;
       	#color: #cdd6f4;
       	#text-shadow: none
       #}

       #.time {
       	#font-size: 1rem;
       	#font-weight: bold;
       	#background: transparent;
       	#color: #cdd6f4;
       	#text-shadow: none;
       	#margin-right: 18px
       #}

       #.body {
       	#font-size: 1rem;
       	#font-weight: bold;
       	#background: transparent;
       	#color: #cdd6f4;
       	#text-shadow: none
       #}

       #.control-center {
       	#background: #11111b;
       	#border: 1.5px solid #b4befe;
       	#color: #cdd6f4;
       	#border-radius: 10px;
       #}

       #.control-center-list {
       	#background: transparent
       #}

       #.control-center-list-placeholder {
       	#opacity: 0.5
       #}

       #.floating-notifications {
       	#background: transparent;
       #}

       #.blank-window {
       	#background: alpha(black, 0.1)
       #}

       #.widget-title {
       	#color: #b4befe;
       	#background: #181825;
       	#padding: 3px 6px;
       	#margin: 5px;
       	#font-size: 1rem;
       	#border-radius: 10px;
       #}

       #.widget-title>button {
       	#font-size: 0.75rem;
       	#color: #cdd6f4;
       	#border-radius: 10px;
       	#background: transparent;
       	#border: 0.5px solid #b4befe;
       #}

       #.widget-title>button:hover {
       	#background: #f7768e;
       	#color: #b4befe;
       #}

       #.widget-dnd {
       	#background: #181825;
       	#padding: 3px 6px;
       	#margin: 5px;
       	#border-radius: 10px;
       	#font-size: 1rem;
       	#color: #cdd6f4;
       #}

       #.widget-dnd>switch {
       	#border-radius: 10px;
       	#/* border: 1px solid #7aa2f7; */
       	#background: #b4befe;
       #}

       #.widget-dnd>switch:checked {
       	#background: #f38ba8;
       	#border: 1px solid #f38ba8;
       #}

       #.widget-dnd>switch slider {
       	#background: #1e1e2e;
       	#border-radius: 10px
       #}

       #.widget-dnd>switch:checked slider {
       	#background: #1e1e2e;
       	#border-radius: 10px
       #}

       #.widget-label {
       	#margin: 5px;
       #}

       #.widget-label>label {
       	#font-size: 1rem;
       	#color: #cdd6f4;
       #}

       #.widget-mpris {
       	#color: #cdd6f4;
       	#background: #181825;
       	#padding: 3px 6px;
       	#margin: 5px;
       	#border-radius: 10px;
       #}

       #.widget-mpris>box>button {
       	#border-radius: 10px;
       #}

       #.widget-mpris-player {
       	#padding: 3px 6px;
       	#margin: 5px;
       #}

       #.widget-mpris-title {
       	#font-weight: 100;
       	#font-size: 1rem;
       #}

       #.widget-mpris-subtitle {
       	#font-size: 0.75rem;
       #}

      #.widget-menubar>box>.menu-button-bar>button {
       	#border: none;
       	#background: transparent
       #}

       #.topbar-buttons>button {
       	#border: none;
       	#background: transparent
       #}

       #.low {
       	#background: #cdd6f4;
       	#padding: 0px;
       	#border-radius: 10px;
       #}

       #.normal {
       	#background: #cdd6f4;
       	#padding: 0px;
       	#border-radius: 10px;
       #}

       #.critical {
       	#background: red;
       	#padding: 0px;
       	#border-radius: 10px;
       #}
    #'';
  #};
}
