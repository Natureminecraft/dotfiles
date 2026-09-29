-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
  output   = "LVDS-1",
  mode     = "highrr",
  position = "0x0",
  scale    = "1",
  disabled = false
})
hl.monitor({
  output   = "HDMI-1",
  mode     = "highrr",
  position = "auto-up",
  scale    = "1",
})
hl.monitor({
  output   = "",
  mode     = "preferred",
  position = "auto",
  scale    = "1",
})
