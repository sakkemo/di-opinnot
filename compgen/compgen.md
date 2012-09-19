Lecture 1
=========
*Coding strand == same as mRNA (i.e. not the model!)
*mutations
*  -aa


Demo Lecture 1
==============
*CDS = coding (DNA) sequence
*HGNC = HUGO gene nomenclature committee
  - Official gene symbols
*RefSeq = NCBI reference sequences, aims to be well annotated, non-redundant and it's curated
*HBB Accession number NM_000518.4

Links
-----

Demo Lecture 2
==============
Bitscore is a normalized score expressed in bits that lets you estimate the
magnitude of the search space you would have to look through before you would
expect to find an score as good as or better than this one by chance.
    S'=\frac{\lambda S - ln(K)}{ln(2)}

E-value (Expectation value): correction of the p-value for multiple testing.
In the context of database searches, the E-value (associated to a score S) is the number of
distinct alignments, with a score equivalent to or better than S, that are expected to occur in
a database search by chance. The lower the E value, the more significant the score is.

http://homepages.ulb.ac.be/~dgonze/TEACHING/stat_scores.pdf

EXAMPLE
-------
*Matches are marked with a bar |, gaps are marked with dashes -.

    Features in this part of subject sequence:
    hemoglobin subunit epsilon

    Score =  118 bits (130),  Expect = 8e-24
    Identities = 113/144 (78%), Gaps = 3/144 (2%)
    Strand=Plus/Minus

    Query  3       ATTTGCTTCTGACACAACTGTGTTCACTAGCAACCTCAAA---CAGACACCATGGTGCAT  59
                   || |||||| |||||| |||   |||||||||| |||  |   | | || ||||||||||
    Sbjct  919717  ATCTGCTTCCGACACAGCTGCAATCACTAGCAAGCTCTCAGGCCTGGCATCATGGTGCAT  919658
    
    Query  60      CTGACTCCTGAGGAGAAGTCTGCCGTTACTGCCCTGTGGGGCAAGGTGAACGTGGATGAA  119
                    | ||| ||||||||||| ||||||| |||  ||||||| ||||| |||| ||||| || 
    Sbjct  919657  TTTACTGCTGAGGAGAAGGCTGCCGTCACTAGCCTGTGGAGCAAGATGAATGTGGAAGAG  919598
    
    Query  120     GTTGGTGGTGAGGCCCTGGGCAGG  143
                   | ||| ||||| ||| ||||||||
    Sbjct  919597  GCTGGAGGTGAAGCCTTGGGCAGG  919574
