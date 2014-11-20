The tutorial at a glance
========================

Step 1: basic client
--------------------

* Usually, first step when creating a GUI app is to draw some mockups. It can be
  done with any tool (including good old paper & pencil), but you'll have to
  consider the ncurses interface, so maybe using libyui itself to write the
  mockup is not a bad idea.
* As explained in "YaST architecture" at
  http://yast.github.io/documentation.html, executing YaST means
  actually calling a YaST client. So let's write a client that will draw our
  mockup.
* We'll create a 'src' directory to mimic the structure described in
  "YaST code organization description" at
  http://yast.github.io/documentation.html
* Let's create ```/clients/mockup.rb``` and ```lib/systemd_journal/mockup_dialog.rb```
  as they are shown in the first commit of this repo. Brief explanation of the
  code.
* ```Y2DIR=src/ /usr/sbin/yast2 mockup``` (the only possible interaction is
  closing) and check result in ```~/.y2log```
* ```Y2DIR=src/ /usr/sbin/yast2 --ncurses mockup``` (press 'esc' to exit)
  and check result in ```~/.y2log```

* Celebrate your first YaST module.

* Not let's try to create a more complex UI. YaST does not impose any
  architectural pattern to your code. Let's try to follow the well known MVC
  approach while still keeping the code as obvious as possible (no Rails-like
  magic to integrate view and controller).
* Modify the code as in commit 83a36cc371
* Link to UI reference for layout documentation
* Explanation of the controller loop: libyui is not event-driven.
* ```Y2DIR=src/ /usr/sbin/yast2 mockup``` and repeat with ```--ncurses```. Keep
  in mind that the ncurses version should fit in 80x25, so resize your xterm
  according. It obviously looks too cluttered in ncurses, we'll need an extra
  modal dialog.
