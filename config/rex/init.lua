-- Migrated from ~/.tmux.conf (prefix ctrl+shift+a)

-- Send the prefix to the program in the pane (tmux: bind C-Space send-prefix)
rex.bind("ctrl+shift+a>ctrl+space", "pane.send_key", { key = "ctrl+shift+a" })

-- Move between panes with vim keys
rex.bind("ctrl+shift+a>h", "pane.focus", { direction = "left" })
rex.bind("ctrl+shift+a>j", "pane.focus", { direction = "down" })
rex.bind("ctrl+shift+a>k", "pane.focus", { direction = "up" })
rex.bind("ctrl+shift+a>l", "pane.focus", { direction = "right" })

-- Split panes
rex.bind("ctrl+shift+a>=", "pane.split", { direction = "right" })
rex.bind("ctrl+shift+a>-", "pane.split", { direction = "down" })
