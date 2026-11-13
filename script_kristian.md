# Kristian

## Slide 1 — The Zombie Checkpoint

Our group studied a zombie checkpoint. We used a decision tree to decide who enters the town and who goes to quarantine. We compared two trees with different costs for mistakes.

## Slide 2 — The data and the baseline

We have records for 90 people: 69 humans and 21 zombies. The data include temperature, reaction time, groan volume, bite marks, and umbrellas. Letting everyone in would be about 77 percent accurate, but every zombie would enter. That shows why accuracy alone can mislead us.

## Slide 3 — Body temperature drives the default tree


The first tree uses only body temperature. Below 36 point 35 degrees Celsius, the person goes to quarantine. At or above that temperature, the person enters. Temperature is the strongest sign in this tree.

## Slide 4 — The default tree misses two zombies


On the same 90 records used to build it, this tree lets in two zombies and wrongly quarantines three humans. Accuracy is about 94 percent. Both missed zombies have a temperature of 36 point 7 degrees, so the temperature rule misses them.

## Slide 5 — A 10× penalty adds a bite-mark check

Now we make missing a zombie ten times more costly than quarantining a human. The new tree adds a bite-mark check. A person enters only if their temperature is at least 36 point 35 degrees and they have no bite marks.



