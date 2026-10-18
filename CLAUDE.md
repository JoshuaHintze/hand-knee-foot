# Hand, Knee & Foot

Personal project: a phone-first scorekeeper and a one-page printable rules sheet for our house rules of the card game Hand, Knee & Foot.

Live at https://hand-knee-foot.vercel.app (Vercel project `hand-knee-foot`, account gimpmaster).

## Files
- `index.html` — the whole scorekeeper (plain HTML/CSS/JS, no build step). One team per phone; rounds and point values are saved in the browser's localStorage (`hkf.game.v2`, `hkf.settings`).
- `rules-sheet/rules-sheet.html` — source of the printable sheet (US Letter, one side).
- `rules-sheet.pdf` — generated from the sheet; the site's Rules tab links to it for download. Commit it, since Vercel serves it.
- `scripts/build-pdf.sh` — regenerates the PDF with headless Chrome and fails if it no longer fits on one page.
- `.vercelignore` keeps the sheet source, scripts and this file off the live site.

## House rules (source of truth)
- 6 decks with jokers, 4–6 players in partnerships. Everyone deals their own: hand 15, knee 13, foot 11.
- Turn: draw 2 (or take the discard pile), lay down, discard 1. Taking the discard pile needs 2 cards matching the top card, laid down with it, and you take the entire pile.
- Knee: picked up once the team completes its first book; both partners can pick up at the same time. Foot: once your hand is empty.
- Books are 7 cards. Wilds are 2s and jokers. Required to go out: Sevens, Fives, Wilds, Clean, Dirty.
- Required Sevens and Fives must be clean. Extra 7s/5s piles may use wilds after the required ones are closed; they score as dirty books.
- Dirty piles must always have more naturals than wilds, even while being built.
- Red 3s are banked immediately (first turn: draw a replacement for each one dealt). 100 each; seven together = 1,000; each extra +100 (5 = 500, 8 = 1,100).
- Black 3s can't be booked; discard them.

Scoring: Sevens 5,000 · Fives 3,000 · Wilds 2,500 · Clean 500 · Dirty 300. Cards: joker 50, 2 = 20, ace 20, 8–K 10, 4–7 5. Held at the end: red 3 −500, black 3 −100. Cards laid down count plus; cards left in hand/knee/foot count minus.

Not decided yet (the app's Points tab lets players set them): going-out bonus (0 for now), and whether extra wild 7s/5s books score something other than a dirty book.

## Working rules
- A rule change goes in all three places: this file, `rules-sheet/rules-sheet.html`, and the Rules tab text and defaults in `index.html` (`HOUSE`, `BOOKS`, `renderRules`).
- After editing the sheet, run `sh scripts/build-pdf.sh`; it must stay one page.
- The site must work at phone width (375px) with no sideways scrolling.
- Deploy: `vercel deploy --prod --yes` from this folder. The CLI is at `~/Library/pnpm/bin/vercel` if `vercel` isn't on PATH. Check the live site returns 200 afterwards.
