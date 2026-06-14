
# PDF Viewer

This is a framebuffer pdfviewer:

https://github.com/bemjo/pdfviewer

forked from:

https://github.com/jichu4n/jfbview

That is a modified version with MiSTer specific optimizations and fixes not appropriate for upstream.
This adds escape, and enter to the keymapping for the viewer. This will allow it to work well with the joystick emulation.
This add resume support which currently saves your last page in a metadata hashtable in the docs/ directory of your stored documents,
your USB drive, network mount, or SD card.

## JOYSTICK:

The joystick emulation maps to these keys:
```
right,left,up,down
btn1 - enter   -- next page
btn2 - escape  -- quit
btn3 - space   -- down
btn4 - tab     -- index view
L    - pageup  -- prev page
R    - pagedn  -- next page
```


## Glow MD Viewer

We also include the Glow Viewer: https://github.com/charmbracelet/glow/
https://github.com/charmbracelet/glow/releases/download/v1.4.1/glow_1.4.1_linux_armv6.tar.gz

## Less file

This creates a less key file that we use to set esc/esc or tab to exit from the less pager.
