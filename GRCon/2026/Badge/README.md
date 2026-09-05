# Badge Generator
## What you'll need

### Data

.CSV file with the following columns:

- `Attendee name`
- `Alias / Call Sign`
- `Company`

This can be exported from pretix (perhaps via XLSX export)

### Design

svg in template.svg

- Format: 4"×3"
- Bleed: 0.25"
- Extra space around for crop mark: 0.25" (Thus, a total document size of 5"×4")
- Crop Marks ;)

Refer to 2025's design for an example.

#### Fonts

2025's design uses the Frutiger's legendary "Avenir Next" typeface, as
distributed for free by Microsoft. Sadly, MS is inconsistent with font names.
If you get a warning that the font "Avenir Next LT Pro" was not found, check
what the name of the Avenir Next font on your machine is.

### Administrative knowledge

The desired number of total badges, which is typically > than registered, adding empty badges to the print job.

### Software

- a recent Python 3 to run the CSV converter script (3.9 should do, though)
- [typst](https://github.com/typst/typst/releases)
- Avenir Next (s.a.)

## How to run



1. Convert CSV to JSON file; assuming 300 total badges and less than that registered people:
   ```shell
   ./loadlist.py -o lists/latest.json list/export-of-2038-01-01.csv 300
   ```
2. Compile the PDF:
   ```shell
   typst compile page.typ
   ```
