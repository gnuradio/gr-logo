#!/usr/bin/env python3
import csv
import json
import argparse

parser = argparse.ArgumentParser()
parser.add_argument(
    "in_file", metavar="IN_FILE.CSV", type=argparse.FileType("r", encoding="utf-8")
)
parser.add_argument("total", metavar="total pages", nargs="?", type=int, default=0)
parser.add_argument("-o", "--output", type=argparse.FileType("w", encoding="utf-8"))
parser.add_argument("-n", "--no-affiliation", action="store_true", help="Don't show affiliation on badges")
args = parser.parse_args()
outlist = []
with args.in_file as csvfile:
    # gotta be a bit stupid here, the CSV has a duplicate conflicting column
    # "Company", so we cannot simply use DictReader, and need to look up
    # indices first
    dictreader = csv.DictReader(csvfile)
    name = dictreader.fieldnames.index("Attendee name")
    handle = dictreader.fieldnames.index("Alias / Call Sign")
    company1 = dictreader.fieldnames.index("Company")
    try:
        company2 = dictreader.fieldnames.index("Company", company1 + 1)
    except ValueError:
        company2 = company1

    reader = csv.reader(csvfile)
    for row in reader:
        comps = (row[company1], row[company2])
        # comps = [comp if comp != "Retired" else "" for comp in comps]

        if comps[0] == comps[1]:
            company = comps[1]
        else:
            company = max(comps, key=len)
        dic = {
            "name": row[name],
            "handle": row[handle],
            "affiliation": company if not args.no_affiliation else "",
        }
        outlist += [dic]

outlist = sorted(outlist, key=lambda row: row["name"].upper())
if args.output:
    outfile = args.output
else:
    outfile = open(
        args.in_file.name.replace(".csv", "") + ".json", "w", encoding="utf-8"
    )
json.dump(
    {"list": outlist, "total_pages": max(args.total, len(outlist))},
    outfile
)
