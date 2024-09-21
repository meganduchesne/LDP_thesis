---
editor_options: 
  markdown: 
    wrap: 72
bibliography: references.bib
---

#WELCOME

##Study information This project is based on my MSc thesis work which
uses 49 years of morphological and survival data for a population of
song sparrows (Melospiza melodia) on Mandarte Island to test whether
selection has occurred on traits linked to competitive ability in
response to invasion by a dominant competitor (Paserella unalaschcensis)
4 decades ago.

#Location X̱OX̱ DEȽ / Mandarte Island., B.C. (48.6329°, longitude
-123.2859°)

#Duration Data collection began in 1975 and has continued annually
since. This study uses morphological data from 1975-2023. Over-winter
survival in the last year of the study relied on data from the spring of
2024.

#Data collection

Methods for monitoring and collecting data on the song sparrows of
Mandarte Island are described in detail in [@conserva2006]

##Survival status

Over-winter survival of individuals from the previous breeding season is
assessed in April each year and is scored as a binary response. Birds
are considered to have survived over winter if they were seen with two
independent sightings or a very confident sighting (caught in a net,
there were notes that bands double checked, or bird movement mapped by a
skilled observer). Because all individuals are colour-marked and the
small island (6ha) is searched systematically each spring, we assume our
observations of over-winter survival (hereby survival) are without
error. In fact, mark-recapture analyses estimate our resighting
probability to be 0.998 (Wilson et al., 2007). Individuals not sighted
during the spring census may have emigrated to nearby islands, a
behaviour which is rare in adult song sparrows, and nonetheless
represent birds that did not survive the winter on Mandarte (hereby
non-survivors).

##Morphological measures

Bill length, depth and width were measured for each captured bird using
vernier calipers to the nearest 0.1mm. To ensure high repeatability of
measures among observers, the same observer measured birds and trained
other observers to measure similarly for 41 of 48 years (1982-2023). All
traits had moderate-good repeatability (average intraclass correlation
coefficient= 0.602) and were weakly correlated (Pearson's correlation
coefficients \<0.3).

#Explanations of files

##Survival data:

The survival file was created by Amy Marr in 2003.

Notes on construction of the survival file:

Birds get a line with their age for every year of their life. Mated and
unmated birds of both sexes are included in this dataset Birds get a
line at age zero if their band combination was seen at or after day 24.
Immigrants do not get a line at age zero, all other birds do. Sex = 0 if
the bird is age 0, even if the sex is later discovered. Immigrant age is
assumed to be 1 in the first year they are seen on the island. Survival
file columns contain the following information:

age: 0=sighted independent from parental care, 1=age 1, etc. sex: 0=sex
unknown, all independent juveniles get a zero, 1=female, 2=male surv:
survived to next year (1=yes, 0=no) cens: censor bird in survival
analyses (experiments, died in net, etc). Birds killed in experiments
are censored as per Lukas' recent suggestion (cens=1) is: immigrant
status, 1=immigrant, 0=resident-hatched ninecode: nine digit bird
combination expt: experiment id notes: notes about experiment or other
notes

##Morphological data:

The morphology file was created by Megan Duchesne in 2023.
