# Todo list keeper

A simple todo list keeper, with the help of git.


## Commands

`todo` has the following commands.

```
$ todo
```
Opens the global todo list with your editor.

```
$ todo $name
```

Opens the `$name` todo list.

```
$ todo list
```

Outputs the global todo list to standard out.

```
$ todo list $name
```

Outputs the `$name` todo list to standard out.

```
$ todo sync
```

Calls git push on the todo repo. Requires a remote to be setup manually.

```
$ todo ls
```

List all todo lists. Effectively calling `ls` in the todo directory.


## Environment variables

The following environment variables changes the behaviour of `todo`.

```
$EDITOR
```

Determines what editor to use when editing a todo list, defaults to vim.

```
$TODO_ROOT
```

The root directory which contains all todo lists, defaults to "~/.todo".

```
$TODO_AUTO_SYNC
```

If this is set to `true`, or `1`, todo will call `sync` after each `open` call,
defaults to false.


## License

Licensed under either of

 * Apache License, Version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or https://www.apache.org/licenses/LICENSE-2.0)
 * MIT license ([LICENSE-MIT](LICENSE-MIT) or https://opensource.org/licenses/MIT)

at your option.

### Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall be
dual licensed as above, without any additional terms or conditions.
