
# PDF Viewer 

This is a framebuffer pdfviewer from:

https://github.com/jichu4n/jfbview

That is compiled to run on MiSTer. There is a patch that adds escape, and enter to the keymapping for the viewer. This will allow it to work well with the joystick emulation.


## JOYSTICK:

The joystick emulation maps to these keys:
```
right,left,up,down
btn1 - enter   -- next page
btn2 - escape  -- quit
btn3 - space   -- down
btn4 - tab     -- index view
```


## Glow MD Viewer

We also include the Glow Viewer: https://github.com/charmbracelet/glow/
https://github.com/charmbracelet/glow/releases/download/v1.4.1/glow_1.4.1_linux_armv6.tar.gz

## Less file

This creates a less key file that we use to set esc/esc or tab to exit from the less pager.
