# Getting started

All you need to reproduce this disassembly is Python 3, GNU make and
[Pasmo](https://pasmo.speccy.org/). The cartridge image **does not travel in
this repository**: bring your own.

```
penguinadventure.rom    131,072 bytes
sha256                  525608aa990e1a19285edc98dec3f0aa11339d8a17641c89df3966845d10cc6a
```

With that file at the root of the repository:

```
make            # listing, verification, consistency and tests
```

## What each step does

| target | what it does |
|---|---|
| `make listado` | generates the sixteen `.asm` files from the binary, the notes and the seeds |
| `make verify` | reassembles each bank and the whole ROM, and compares the sha256 |
| `make sanity` | checks that not one byte is left unassigned to code or data |
| `make test` | the 30 tests |
| `make densidad` | how many instructions carry a comment, bank by bank |
| `make cifras` | rewrites the numbers in both READMEs by counting over the tree |
| `make imagenes` | draws the 35 PNGs from the ROM |
| `make web` | generates the HTML pages and checks the links |

`make verify` is the one that decides. It must print `OK: reproducible byte a
byte` seventeen times: once for each of the sixteen banks and once for the whole
ROM. If one fails, the listing is lying.

## Where everything is

- `src/penguinadventure_pNN.asm` — the listing, one per bank. It is
  **generated**: never edited by hand.
- `src/pNN.notes` — the labels (`L`), line comments (`C`), data ranges (`D`) and
  routine headers (`B`). This one **is** edited.
- `src/pNN.entries` — the tracer's entry points, each with its reason written
  next to it.
- `tools/` — the disassembler, the tracer, the drawing code and the checks.
- `work/` — intermediates. Ignored except `work/msx.sym`, which is needed to
  generate the listing and therefore does travel.

## Why the notes live outside the listing

Because the listing is regenerated whole every time. If the comments lived
inside the `.asm`, any change to the tracing would lose them. Living in the
`.notes`, anchored to their address, they survive the listing being rebuilt.

And out of that comes a check that is not cosmetic: `tools/valida_c.py` verifies
that every comment lands on the **first byte** of an instruction. One anchored
mid-instruction never appears in the listing, and nobody notices it was lost.
