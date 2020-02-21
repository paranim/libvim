[![Build Status](https://dev.azure.com/onivim/oni2/_apis/build/status/onivim.libvim?branchName=master)](https://dev.azure.com/onivim/oni2/_build/latest?definitionId=4&branchName=master)

## What is `libvim`?

`libvim` is a fork of [Vim](https://github.com/vim/vim), with the goal of providing a [minimal C-based API](https://github.com/onivim/libvim/blob/master/src/libvim.h), modelling Vim modal editing. It does not include any user interface at all (not even a terminal UI), and is primarily responsible for acting as a fast buffer manipulation engine, faithful to Vim keystrokes. It's still a work-in-progress and there is lots of work left to stabilize.

If you're looking for a terminal Vim, check out [neovim](https://github.com/neovim/neovim), or a GUI Vim, check out [Onivim 2](https://v2.onivim.io).

## Why?

`libvim` is primarily intended for [Onivim 2](https://v2.onivim.io). After implementing several iterations of 'UI Vims' between v1, v2, and other projects, the abstraction I wished to have was a sort of a pure functional Vim, completely decoupled from terminal UI - where 'vim' is a function of `(editor state, input) => (new editor state)`. As Onivim 2 completely handles the rendering layer, this Vim-modelled-as-a-pure-function could focus on just buffer manipulation.

To that end, `libvim` exposes a simple C API for working with Vim, and supports listening to buffer changes, messages, etc. 

It is responsible for:
- Managing and manipulating buffers
- Buffer manipulation in response to input
- Parsing and sourcing VimL
- Handling key remaps

It is __NOT__ responsible for:
- Any sort of UI rendering (terminal, etc)
- Mouse support
- Syntax Highlighting
- Spell Checking
- Terminal Support
- Completion
- Input methods (IME)

All of these are intended to be handled by the consumer of the library - leaving `libvim` to be focused on the job of fast buffer manipulation.

`libvim` builds cross-platform (since [Onivim 2](https://v2.onivim.io) requires it!), as well as for WebAssembly - we'd like to port our v1 tutorials to a browser-based experience.

There are other interesting applications of such an 'abstracted Vim':
- WebAssembly builds could be useful for implementing Vim modes in browsers / websites
- Native builds could be useful for applications that want Vim-native bindings - it'd be a nice foundation for implementing `readline`, for example.

## API

For an example of the API usage, check out the [apitests](https://github.com/onivim/libvim/blob/master/src/apitest) like [normal_mode_motion](https://github.com/onivim/libvim/blob/master/src/apitest/normal_mode_motion.c). The full API is available here: [libvim.h](https://github.com/onivim/libvim/blob/master/src/libvim.h)

The heart of the API is `vimInput` which takes a single key, and is synchronously processed by the state machine. 'Side-effects' like buffer updates, messages, etc can be subscribed to via callbacks like `vimSetBufferUpdateCallback`.

This library is in active development and we currently make no guarantees about backwards compatibility. Use the API at your own risk.

## Compiling ##

### Windows

Install WSL (Windows Subsystem for Linux), and from there, do:

```
sudo apt install gcc-mingw-w64-x86-64
cd src
build/build-windows.sh
```

## Supporting

If `libvim` is interesting to you, and you'd like to support development, consider the following:

- [Pre-order](https://v2.onivim.io) Onivim 2
- Support on [Patreon](https://www.patreon.com/onivim)

## Contributing

If you would like to help making `libvim` better, see the [CONTRIBUTING.md](https://github.com/vim/vim/blob/master/CONTRIBUTING.md) file.

Some places for contribution:
- Help us [add test cases](https://github.com/onivim/libvim/tree/master/src/apitest)
- Help us remove [code](https://github.com/onivim/libvim/pull/31) or [features](https://github.com/onivim/libvim/pull/30) that aren't required for `libvim`
- Help us port [patches](https://github.com/vim/vim/commits/master) from Vim

## License

`libvim` code is licensed under the [MIT License](./LICENSE).

It also depends on third-party code, notably Vim, but also others - see [ThirdPartyLicenses.txt](./ThirdPartyLicenses.txt) for license details.
