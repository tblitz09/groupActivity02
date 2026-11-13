# Group 2: Zombie Checkpoint — Questions and Answers

Analysis uses the supplied CSV (90 people: 69 humans, 21 zombies) and default `rpart` classification settings from `graph.R`. “Zombie” is the positive class. Full-data results below describe the records used to fit each tree, not unseen-case performance.

## Research questions

**Q1. Which signs best separate zombies from humans?**  
**A.** Body temperature is the strongest separator and the default tree's only split. Quarantine people below **36.35°C** and admit everyone else. With the 10× loss, the tree also quarantines anyone with **at least one bite mark**. Reaction time and groan volume have importance as alternative/surrogate splits but do not appear in these final rules. Umbrella possession does not appear in either tree.

**Q2. How many zombies get through, and how many humans are wrongly quarantined?**  
**A.** On all 90 fitting records, the default tree misses **2 zombies** and quarantines **3 humans**. It admits 66 humans and catches 19 zombies. Accuracy is **94.4%** and zombie recall is **90.5%**.

**Q3. What changes when missing a zombie costs ten times as much?**  
**A.** The full-data tree adds a bite-mark check for people at or above 36.35°C. It misses **0 zombies** but quarantines **15 humans**. Accuracy falls to **83.3%**, while zombie recall rises to **100%**. Cost, defined as `10 × missed zombies + quarantined humans`, falls from **23 to 15** on these fitting records.

| Actual class | Default: admit | Default: quarantine | 10× loss: admit | 10× loss: quarantine |
|---|---:|---:|---:|---:|
| Human | 66 | 3 | 54 | 15 |
| Zombie | 2 | 19 | 0 | 21 |

## Discussion questions

**Q4. How accurate is a useless model that lets everyone in?**  
**A.** **76.7%** (69/90), but it misses all 21 zombies. Its zombie recall is 0% and its 10× cost is 210.

**Q5. Why is accuracy alone dangerous?**  
**A.** Humans dominate the dataset, so accuracy can look high even when a model misses zombies. It also treats the two mistakes equally. Report both mistake counts, zombie recall, and the chosen cost alongside accuracy.

**Q6. Which mistake is worse, and would everyone agree?**  
**A.** Under the scenario's 10:1 assumption, admitting a zombie is worse because it threatens the town. A wrongly quarantined human may disagree because confinement also causes harm. The cost ratio is a policy choice, and quarantine should include prompt review and retesting.

**Q7. Which zombies are hardest to catch, and why?**  
**A.** The default tree misses CSV data rows **6 and 84** (excluding the header). Both have a body temperature of **36.7°C**, which the tree treats as human. Their reaction times are 304 and 297 ms, and their groans are 47 and 42 dB, overlapping human values. They have 2 and 1 bite marks, respectively, so the full-data 10× tree catches both. Early infection is a possible explanation for human-like signs, but the data do not establish a cause.

**Q8. What real-world problems have unequal mistake costs?**  
**A.** In disease screening, a false negative can delay care, while a false positive can cause anxiety and extra testing. In fraud detection, missed fraud causes losses, while blocking a legitimate payment inconveniences the customer. The preferred tradeoff depends on the setting.

**Q9. Which tree should guard the gate?**  
**A.** The full-data 10× tree is the provisional choice under the stated cost ratio: its fitting-record cost is lower. However, the supplied seed-301 split trains on 68 people and tests on 22 (18 humans, 4 zombies). When both trees train only on those 68 people, both use the same temperature rule, miss **2 zombies**, quarantine **0 humans**, and achieve **90.9% accuracy**, **50% zombie recall**, and cost **20**. This split's training data contain no zombies at or above 36.35°C, so the loss penalty does not produce the extra bite check. The full-data improvement is not evidence of better unseen-case performance. More representative validation is needed before relying on either tree.
