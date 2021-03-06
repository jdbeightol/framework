# framework.sh

```
  __                                             _          _     
 / _|_ __ __ _ _ __ ___   _____      _____  _ __| | __  ___| |__  
| |_| '__/ _` | '_ ` _ \ / _ \ \ /\ / / _ \| '__| |/ / / __| '_ \ 
|  _| | | (_| | | | | | |  __/\ V  V / (_) | |  |   < _\__ \ | | |
|_| |_|  \__,_|_| |_| |_|\___| \_/\_/ \___/|_|  |_|\_(_)___/_| |_|
                                                                  
```

**framework.sh** adds a lightweight function for bash script re-use called
`require`.  shell libraries have significant gotchas and frustrations for
complex tasks.  if in doubt about complexity, consider another language instead,
and remember:

>       "Shell functions are totally f***ed."
>          - Greg from http://mywiki.wooledge.org/BashWeaknesses

## installation

the simplest approach to install this script is to clone this repo somewhere
under `${HOME}/.local` and then source the **framework.sh** script in your
`.bashrc` and/or `.bash_profile`. consider sourcing it in both if you're unsure
when each one is loaded in your workflow.  i.e,

```bash
mkdir -p "${HOME}/.local/lib"
git -C "${HOME}/.local/" clone https://github.com/jdbeightol/framework.git
```

**example `.bashrc` or `.bash_profile` snippet**
```bash
source "${HOME}/.local/framework/framework.sh"
```

after making the above change, you will need to source your `.bashrc` or close
and re-open your shell for the changes to take effect.  you may also want to log
out and re-login or reboot your machine to be really sure that your environment
is sane when you start using it.

## getting started

to get a feel for how **framework.sh** works, let's run though the provided
example script.  from the root of this repository, run the following,

```bash
bash # let's drop into a subshell, so that we can return to the previous state easily
source framework.sh # source the framework library
cd example # move into the example directory
export FRAMEWORK_LIB="${PWD}/lib" # override the library directory for this example
./example.sh # run the example script

declare -F | awk '/hello::/' # since `./example.sh` ran in a subshell, nothing should remain from its require statement
require hello # you can play with imported functions directly if you run `require` here
declare -F | awk '/hello::/' # see?

hello::world # have fun!

exit # when you're finished, leave the subshell; no state from the above commands should linger
```

also included in the example directory is a sample Makefile to `install` and
`uninstall` library files into the a users `FRAMEWORK_LIB` directory.  the
makefile also has a `test-env` target to demonstrate a possible development
environment setup.

## conventions

some conventions for using **framework.sh**:
- all functions sourced from a library must prefix their library's name with a
  `::` to namespace the function names.  e.g., for a library named  `example`,
  all functions declared should start with `example::`.  an exception to this
  rule could be made for user-callable functions like `require`.
- library names must not include the trailing `.sh`.  calling `require example`
  will attempt to load `example.sh` and expect its functions to be prefixed with
  `example::`.  calling `require example.sh` will attempt to load
  `example.sh.sh` and expect its functions to be prefixed with `example.sh::`.
- all exported library variables should start with the capitalized library name
  followed by an underscore.  e.g., for a library named `example`, its exported
  variables should start with `EXAMPLE_`.
- users must set `FRAMEWORK_LIB` with a single, valid directory. no
  comma-separated PATH-like variables will be allowed for now
- library files should not cause side-effects when sourced.  a library should
  only define functions and variables unless absolutely necessary.

failure to follow the conventions may result in later headaches

## troubleshooting and gotchas

right off the bat, if something is giving you difficulty with this system,
consider using a language other than bash.  bash is great for glue, but complex
processes or business logic should probably be represented in a language where
libraries and dependencies can be expressed as a first-class concept.

some gotchas to note with a setup like this:
- bash environment is forever!  once something is exported, it will stay
  exported in that form until overwritten, and calling `require` does not
  reload previously loaded libraries.
- libraries imported with `require` that, by chance, match an unrelated bash
  function already defined in your environment will not be loaded.  if calling
  `require` does not behave as expected, I suggest checking what functions exist
  in your environment with `declare -F` and searching for any that share a name
  with the library you are attempting to load.

## faq

### why the basckslashes?

normally, using a backslack indicates escaping of a single character in bash,
but in this case the backslash is used to "escape" shell commands to avoid a
user's defined aliases interacting with how this script is supposed to function.

### can I use this with another bash-compatible shell?

maybe.  it wasn't designed for that, and I definitely didn't test that, but you
can.  i suggest trying it and seeing what breaks.  it can't get much more forked
than things already are, right?

### why aren't you capitalizing sentences?

because I'm bored, full of myself, and thought it would be fun.

### this is dumb.

yes.  see Greg's quote above.  if this doesn't help you solve a problem, then
don't use it.
