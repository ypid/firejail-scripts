firejail-scripts
================

Simple wrapper scripts around ``firejail`` and ``xpra`` to sandbox applications using separate home directory for each application.
The script was written with `Qubes OS`_ in mind. It allows you to compartmentalize your workstation using sandboxing powered by Linux using ``firejail``. If you later decide you want strong sandboxing, you can also use this script together with Qubes OS.

Checkout the example script `p-banking-iceweasel`_ to get started.
The name is based on my name spacing approach I use for Qubes OS.

`p`
  Personal namespace.

`p-banking`
  Personal banking AppVM.

`p-banking-iceweasel`
  Iceweasel ``firejail`` sandbox inside the ``p-banking`` AppVM.

Installation
------------

Dependencies
~~~~~~~~~~~~

* crudini

.. code-block:: Shell

   apt-get install crudini

firejail-scripts
~~~~~~~~~~~~~~~~

.. code-block:: Shell

   mkdir --parents ~/.sandboxes/bin
   git clone https://github.com/ypid/firejail-scripts.git ~/.sandboxes/firejail-scripts
   ln -s ~/.sandboxes/firejail-scripts/config_* ~/.sandboxes/bin
   ## Just symlink additional sandboxes using the same program
   ln -s ~/.sandboxes/bin/p-banking-iceweasel ~/.sandboxes/bin/p-banking-iceweasel

Usage
-----

.. code-block:: Shell

   ~/.sandboxes/bin/p-banking-iceweasel

Or:

.. code-block:: Shell

   export PATH="${PATH}${PATH+:}${HOME}/.sandboxes/bin"
   p-banking-iceweasel

Or:

.. code-block:: Shell

   ~/.sandboxes/bin/config_handle_desktop_entries
   ## Now you can use your window manager to start the sandboxed application.

.. _`Qubes OS`: https://www.qubes-os.org/
.. _`p-banking-iceweasel`: p-banking-iceweasel
