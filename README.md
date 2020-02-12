# Elisper

An attempt at writing my first lisp interpreter, in Elixir.

This work is primarily inspired by the textbook "Structure and Interpretation of Computer Programs" by Abelson and Sussman. While the project presenlty falls short of a full implemtnation of the [Scheme specification](https://cs61a.org/articles/scheme-spec.html) it does support a subset of primitive procedures as a jumping off point.

## Overview

You can run the interpreter from iex by starting the project up with mix as follows from the project root:

```bash
> iex -S mix
iex(1)> Elisper.repl
elisper> (*(+ 1 2 3)(+ 4 5))
54.0
```