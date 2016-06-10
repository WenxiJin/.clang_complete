# clang_complete
Scripts for clang completion

This script is for generating a *.clang_complete* that could be utilized by
emacs *irony-mode* or *company-clang mode*.

It takes *make VERBOSE=1* log as input to generate the desired *.clang_complete*
file.
    $ make VERBOSE=1 > compile.log
or
    $ make V=1 > compile.log
even better with
    $ make -n > compile.log

**Note**: CMake-generated Makefiles only support VERBOSE=1, not
V=1. *compile.log* could be any name you want.

    $ ruby cc_args.rb compile.log

**TODO**: allow "-include ../some_dir/some_header"
