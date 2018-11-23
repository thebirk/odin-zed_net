odin-zed_net
==

**NOTE:** Windows is currently the only supported platform. Linux is not hard to set up so if you need this feel free to open an issue or message me on the https://handmade.network/ Discord

I recommend cloning the library into the `shared` collection.
```
> cd odin/shared
> git clone https://github.com/thebirk/odin-zed_net.git zed_net
```

Then you have to compile the libraries (make sure that you have called vsvarsall x64 in this prompt)
```
> cd lib
> build.bat
```

Congratulations! You can now start using zed_net. Take a look inside the main file for a very basic TCP server.
