firejail-scripts
================

Simple wrapper scripts around ``firejail`` and ``xpra`` to sandboxing applications using separate home directory for each application.
The script was written with `Qubes OS`_ in mind. It allows you to compartmentalize your workstation using sandboxing powered by Linux using ``firejail``. If you later decide you want strong sandboxing, you can also use this script together with Qubes OS.

Checkout the example script `p-banking-iceweasel`_ to get started.
The name is based on my name spacing approach I use for Qubes OS.

`p`
  Personal namespace.

`p-banking`
  Personal backing AppVM.

`p-banking-iceweasel`
  Iceweasel ``firejail`` sandbox inside the ``p-banking`` AppVM.

Installation
------------

.. code-block:: Shell

   mkdir --parents ~/.sandboxes/firejail-scripts
   git clone https://github.com/ypid/firejail-scripts.git ~/.sandboxes/firejail-scripts
   ln -s ~/.sandboxes/firejail-scripts/common.sh ~/.sandboxes/
   ln -s ~/.sandboxes/firejail-scripts/handle_desktop_entries ~/.sandboxes/
   cp ~/.sandboxes/firejail-scripts/p-banking-iceweasel ~/.sandboxes/

Usage
-----

.. code-block:: Shell

   ~/.sandboxes/p-banking-iceweasel

Or:

.. code-block:: Shell

   export PATH="${PATH}${PATH+:}${HOME}/.sandboxes"
   p-banking-iceweasel

Or:

.. code-block:: Shell

   ~/.sandboxes/handle_desktop_entries
   ## Now you can use your window manager to start the sandboxed application.

.. _`Qubes OS`: https://www.qubes-os.org/
.. _`p-banking-iceweasel`: p-banking-iceweasel
