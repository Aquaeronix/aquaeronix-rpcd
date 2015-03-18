Aquaeronix: Tools for Accessing the Aquaero5(R) USB Device
--------------------------------------------------------------

[![Build Status](https://travis-ci.org/Aquaeronix/aquaeronix-rpcd.svg?branch=master)](https://travis-ci.org/Aquaeronix/aquaeronix-rpcd)

&copy; 2012 lynix <lynix47@gmail.com>, 

&copy; 2013 JinTu <JinTu@praecogito.com> lynix <lynix47@gmail.com>, 

&copy; 2014 barracks510 <barracks510@gmail.com>, 

&copy; 2015 barracks510 <barracks510@gmail.com>
 

SUMMARY
----------------
Aquaeronix aims at providing a C interface for accessing the Aquaero5(R) USB device by 'Aqua Computer' (http://www.aqua-computer.de).

It consists of a set of functions for data access and conversion, and a command-line tool using these functions as an example implementation.


REQUIREMENTS
----------------
Unlike its predecessor, `aerotools`, which targets the Aquaero(R) 4.00),
Aquaeronix currently uses the USB HIDDEV interface provided by the Linux
kernel via the `/dev/usb/hiddev?` device nodes, so no dependencies for this.


BUILDING
----------------
To build the JSON RPC server `aquaeronix-rpcd`, issue `make all` in the project root. Be sure to install `jsonrpc-c` first, and point to its prefix using the `JRPC_PREFIX` environment variable if not installing to `/usr`.

You need the JSON RPC server `jsonrpc-c` by Henrique Gomes (hmng). It is available under MIT license on GitHub: https://github.com/hmng/jsonrpc-c.


SETUP
----------------
To be able to query the Aquaero5(R) device you have to set appropriate access rights for the device node.

You can either do this manually by identifying the device node using `lsusb` (looking for the Vendor- and Product-ID), or just install a udev rule like this one:

`ATTRS{idVendor}=="0c70", ATTRS{idProduct}=="f001", GROUP="aquaero", MODE="0640"`

This will give all members of the `aquaero` group read access to the device.

As the Aquaero5(R) identifies itself as multiple devices (USB keyboard, mouse and the actual device we want to query) you have to examine which device node represents the data source.

In my case, there is `/dev/usb/hiddev[0-2]` which all match the udev rule provided above. The correct one for me is `/dev/usb/hiddev0`, but I don't know whether it is always the first one. Just try as stated under USAGE - if you choose the wrong one there will simply be no output at all.


USAGE: aerocli-rpcd
----------------
Aquaeronix-aerocli-rpcd, as stated above, is a JSON RPC server that allows for easy data polling in third party applications, possibly over a network connection.

To start it, simply call the binary (`./bin/aerocli-rpcd` from project root).

To change the TCP port `aerocli-rpcd` listens on (default: 9090), use the `-p` parameter.
 

BUGS / CONTACT
----------------
Feel free to report any bugs you find using the 'issues' function on GitHub. You may contact barracks510 at barracks510@gmail.com.


LICENSE
----------------
This program is published under the terms of the GNU General Public License,
version 3. See the file 'LICENSE' for more information.
