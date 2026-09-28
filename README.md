# z/OS COBOL Practice - Z50996.AI.KIRO

Personal z/OS COBOL practice repository for learning and reference.
All source files sourced from mainframe datasets under `Z50996.AI.KIRO.*`.

---

## Repository Structure

| Folder | Mainframe Dataset | Description |
|--------|-------------------|-------------|
| `COBOL/` | `Z50996.AI.KIRO.COBOL` | COBOL source programs |
| `JCL/` | `Z50996.AI.KIRO.JCL` | JCL jobs (compile, run, allocate) |
| `COPYBOOK/` | `Z50996.AI.KIRO.COPYBOOK` | COPY members (reusable structures) |
| `PROPS/` | `Z50996.AI.KIRO.PROPS` | Dataset properties reference |
| `DATA/` | `Z50996.AI.KIRO.INPUT/OUTPUT` | Generic input/output test data (PS) |
| `DATA/SORTFILE/` | `Z50996.AI.KIRO.SORTFILE.*` | SORTFILE program input and sorted output |

---

## Programs

| Program | Description |
|---------|-------------|
| `COBOL/HELLO.cbl` | Simple DISPLAY program - first COBOL on z/OS |
| `COBOL/SORTFILE.cbl` | Sort employee records by name (positions 1-8) |
| `COBOL/S0C7DEMO.cbl` | S0C7 data exception demonstration |

---

## JCL Members

| Member | Description |
|--------|-------------|
| `JCL/ALLOCATE.jcl` | Allocates all Z50996.AI.KIRO.* datasets (run once) |
| `JCL/COMPILE.jcl` | Compile + Link-Edit using IGYWCL proc |
| `JCL/SORTFILE.jcl` | Run JCL for SORTFILE program |
| `JCL/S0C7DEMO.jcl` | Run JCL for S0C7DEMO program |

---

## Mainframe Dataset Properties

| Dataset | DSORG | RECFM | LRECL | Purpose |
|---------|-------|-------|-------|---------|
| Z50996.AI.KIRO.COBOL | PO | FB | 80 | COBOL source |
| Z50996.AI.KIRO.COPYBOOK | PO | FB | 80 | Copy members |
| Z50996.AI.KIRO.OBJ | PO | FB | 80 | Object decks |
| Z50996.AI.KIRO.LOAD | PO(PDSE) | U | - | Load modules |
| Z50996.AI.KIRO.DBRM | PO | FB | 80 | DB2 DBRM |
| Z50996.AI.KIRO.JCL | PO | FB | 80 | JCL members |
| Z50996.AI.KIRO.PROCLIB | PO | FB | 80 | JCL procedures |
| Z50996.AI.KIRO.LIST | PO | FBA | 133 | Compiler listings |
| Z50996.AI.KIRO.SYSOUT | PO | FBA | 133 | Dumps/output |
| Z50996.AI.KIRO.INPUT | PS | FB | 80 | Input test data |
| Z50996.AI.KIRO.OUTPUT | PS | FB | 80 | Output test data |

---

## ACS Policy Notes (This System)
- `SPACE` unit must be **TRK** — CYL is rejected
- Load library must be **PDSE** (`DSNTYPE=LIBRARY`)
- Sizes over 200KB are auto-reduced by SMS

---

## Compile & Run Flow
```
1. Upload source  → Z50996.AI.KIRO.COBOL(PGMNAME)
2. Edit COMPILE.jcl → change member name to PGMNAME
3. Submit COMPILE.jcl from Z50996.AI.PRACTICE.JCL
4. Submit PGMNAME.jcl from Z50996.AI.KIRO.JCL
```
