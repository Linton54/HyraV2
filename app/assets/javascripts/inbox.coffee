



$ ->
  if $('.inbox_wrap').length > 0
    return InboxPoller.poll()
