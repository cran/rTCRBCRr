
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![R](https://github.com/sciencepeak/rTCRBCRr/actions/workflows/r.yml/badge.svg)](https://github.com/sciencepeak/rTCRBCRr/actions/workflows/r.yml)
[![R-CMD-check](https://github.com/sciencepeak/rTCRBCRr/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/sciencepeak/rTCRBCRr/actions/workflows/check-standard.yaml)

# rTCRBCRr <img src='man/figures/logo.png' align="right" height="139" />

The goal of rTCRBCRr is to process the results from clonotyping tools
such as trust, mixcr, and immunoseq to analyze the clonotype repertoire
metrics

## Installation

After the package is accepted by the [CRAN](https://CRAN.R-project.org),
you can **THEN** install the released version of rTCRBCRr from CRAN
with:

``` r
install.packages("rTCRBCRr")
```

You can **ONLY** install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("sciencepeak/rTCRBCRr")
```

## Example code

### Attach packages

``` r
library("rTCRBCRr")
library("magrittr")
library("readr")
```

### Read raw data files (trust generated for example) into a list of data frames

``` r
present_tool <- c("trust", "mixcr")[1]
example_data_directory <- system.file(paste("extdata", present_tool, sep = "/"), package = "rTCRBCRr")
input_paths <- dir(example_data_directory, full.names = TRUE)
input_files <- dir(example_data_directory, full.names = FALSE)
input_files
#> [1] "sample_01.tsv.bz2" "sample_02.tsv.bz2" "sample_03.tsv.bz2"

sample_names <- sub(".tsv.*", "", input_files)
sample_names
#> [1] "sample_01" "sample_02" "sample_03"

raw_clonotype_dataframe_list <- lapply(input_paths, readr::read_tsv) %>%
    magrittr::set_names(., value = sample_names)
raw_clonotype_dataframe_list
#> $sample_01
#> # A tibble: 5,051 x 10
#>    `#count` frequency CDR3nt                CDR3aa V     D     J     C     cid  
#>       <dbl>     <dbl> <chr>                 <chr>  <chr> <chr> <chr> <chr> <chr>
#>  1     1813    0.0664 TGTCAGAAGTATGGTGGCTC~ CQKYG~ IGKV~ .     IGKJ~ IGKC  asse~
#>  2     1684    0.0833 TGCGCGAGAGATGCGGGGGG~ CARDA~ IGHV~ IGHD~ IGHJ~ IGHG1 asse~
#>  3     1648    0.0815 TGTGCGAGAGGGGGAGTGGA~ CARGG~ IGHV~ IGHD~ IGHJ~ IGHG1 asse~
#>  4     1505    0.0551 TGTCAACAGCTTAGTTATTA~ CQQLS~ IGKV~ .     IGKJ~ IGKC  asse~
#>  5     1081    0.0396 TGCATGCAAGGTCTACAAAC~ CMQGL~ IGKV~ .     IGKJ~ IGKC  asse~
#>  6      895    0.0328 TGTCAACAGAGTTACGGTAC~ CQQSY~ IGKV~ .     IGKJ~ IGKC  asse~
#>  7      866    0.0429 TGTGCGAGAGCCTCTTATTA~ CARAS~ IGHV~ IGHD~ IGHJ~ IGHG1 asse~
#>  8      811    0.0297 TGCATGCAAGCTCTACAAAC~ CMQAL~ IGKV~ .     IGKJ~ IGKC  asse~
#>  9      767    0.0281 TGCTGCTCATATACAGGCAG~ CCSYT~ IGLV~ .     IGLJ~ IGLC  asse~
#> 10      761    0.0377 TGTGCTAGGGCGGCCAGTGG~ CARAA~ IGHV~ IGHD~ IGHJ~ IGHG1 asse~
#> # ... with 5,041 more rows, and 1 more variable: cid_full_length <dbl>
#> 
#> $sample_02
#> # A tibble: 5,915 x 10
#>    `#count` frequency CDR3nt                CDR3aa V     D     J     C     cid  
#>       <dbl>     <dbl> <chr>                 <chr>  <chr> <chr> <chr> <chr> <chr>
#>  1     5392    0.0875 TGCATGCAAGCTCTACAAAC~ CMQAL~ IGKV~ .     IGKJ~ IGKC  asse~
#>  2     4470    0.0725 TGCATGCAATCTCTACAAGC~ CMQSL~ IGKV~ .     IGKJ~ IGKC  asse~
#>  3     3852    0.0625 TGTCAGCAGTATAATAACTG~ CQQYN~ IGKV~ .     IGKJ~ IGKC  asse~
#>  4     2893    0.0470 TGCCAACGATATGATACTTA~ CQRYD~ IGKV~ .     IGKJ~ IGKC  asse~
#>  5     2698    0.0438 TGTCAGCAGTATAATAACTG~ CQQYN~ IGKV~ .     IGKJ~ IGKC  asse~
#>  6     1691    0.0509 TGTGCGAGACAAGTTCGTCC~ CARQV~ IGHV~ IGHD~ IGHJ~ IGHG1 asse~
#>  7     1589    0.0478 TGTGCGAGACACGCGGATAC~ CARHA~ IGHV~ IGHD~ IGHJ~ IGHG1 asse~
#>  8     1373    0.0414 TGTGCGAGACAGTTTTACTA~ CARQF~ IGHV~ IGHD~ IGHJ~ IGHG1 asse~
#>  9     1319    0.0397 TGTGCGGCAGAGTGGGCTAG~ CAAEW~ IGHV~ IGHD~ IGHJ~ IGHG1 asse~
#> 10     1172    0.0353 TGTGCGAGGGGGGTCAATTA~ CARGV~ IGHV~ IGHD~ IGHJ~ IGHG1 asse~
#> # ... with 5,905 more rows, and 1 more variable: cid_full_length <dbl>
#> 
#> $sample_03
#> # A tibble: 6,027 x 10
#>    `#count` frequency CDR3nt                CDR3aa V     D     J     C     cid  
#>       <dbl>     <dbl> <chr>                 <chr>  <chr> <chr> <chr> <chr> <chr>
#>  1    14711    0.335  TGTACACTCCTGGTGACCAC~ CTLLV~ IGHV~ IGHD~ IGHJ~ IGHG1 asse~
#>  2    13909    0.341  TGCCAGTCCTATGACAGCAG~ CQSYD~ IGLV~ .     IGLJ~ IGLC  asse~
#>  3     6790    0.166  TGCAGCTCACACACAAGCAG~ CSSHT~ IGLV~ .     IGLJ~ IGLC  asse~
#>  4     4209    0.0959 TGTGCGAGAGCCCTCCCCTA~ CARAL~ IGHV~ IGHD~ IGHJ~ IGHG1 asse~
#>  5     3727    0.0850 TGTGCGAGAGCCCTCCCCTA~ CARAL~ IGHV~ IGHD~ IGHJ~ IGHA1 asse~
#>  6      910    0.0223 TGCAGCTCATATGCAGGCGG~ CSSYA~ IGLV~ .     IGLJ~ IGLC  asse~
#>  7      771    0.0189 TGTGCAGCATGGGAAGACAG~ CAAWE~ IGLV~ .     IGLJ~ IGLC  asse~
#>  8      768    0.0175 TGTGCGAGATTTTTCCATGA~ CARFF~ IGHV~ IGHD~ IGHJ~ IGHG3 asse~
#>  9      701    0.0172 TGCCAGTCCTATGACAGCAG~ CQSYD~ IGLV~ .     IGLJ~ IGLC  asse~
#> 10      628    0.0143 TGTGCGAGAGATGTACTATT~ CARDV~ IGHV~ IGHD~ IGHJ~ IGHG1 asse~
#> # ... with 6,017 more rows, and 1 more variable: cid_full_length <dbl>
```

### Tidy up the clonotype dataframes

The tidy-up consists of four steps, namely four functions:

1.  format_clonotype_to_immunarch_style
2.  remove_nonproductive_CDR3aa
3.  annotate_chain_name_and_isotype_name
4.  merge_convergent_clonotype

``` r
# If you only want to test one sample, you can process the only sample as follows.
the_divergent_clonotype_dataframe <- raw_clonotype_dataframe_list[["sample_01"]] %>%
    format_clonotype_to_immunarch_style(., clonotyping_tool = present_tool) %>%
    remove_nonproductive_CDR3aa %>%
    annotate_chain_name_and_isotype_name %>%
    merge_convergent_clonotype

# Then the only one sample should be put into a list, element of which uses the sample name,
# because the later step need a named list of data frames as input.
divergent_clonotype_dataframe_list <- list(sample_01 = the_divergent_clonotype_dataframe)

# Otherwise, normally you will have multiple samples,
# then functional style of processing is preferred as follows.
divergent_clonotype_dataframe_list <- raw_clonotype_dataframe_list %>%
    lapply(., format_clonotype_to_immunarch_style, clonotyping_tool = present_tool) %>%
    lapply(., remove_nonproductive_CDR3aa) %>%
    lapply(., annotate_chain_name_and_isotype_name) %>%
    lapply(., merge_convergent_clonotype)
```

### Calculate and merge repertoire metrics by chains for each sample in the list

This step consists of three functions.

``` r
# handle repertoire metrics for all the chains.
all_sample_all_chain_all_metrics_wide_format_dataframe_list <- the_divergent_clonotype_dataframe_list %>%
    lapply(., compute_repertoire_metrics_by_chain_name)

all_sample_all_chain_all_metrics_wide_format_dataframe_list
#> $sample_01
#>     diversity  clonality richness  evenness       median
#> IGH 5.4161872 0.26283295     1552 0.7371670 0.0001509510
#> IGK 5.2677388 0.28931127     1656 0.7106887 0.0000908224
#> IGL 4.8949171 0.25490053      713 0.7450995 0.0004132231
#> TRA 4.3018929 0.06585582      100 0.9341442 0.0064377682
#> TRB 4.8358496 0.08467479      197 0.9153252 0.0036429872
#> TRD 0.6730117 0.02904941        2 0.9709506 0.5000000000
#> TRG 0.6931472 0.00000000        2 1.0000000 0.5000000000
#> 
#> $sample_02
#>     diversity  clonality richness  evenness       median
#> IGH 5.3401961 0.28075859     1677 0.7192414 9.231905e-05
#> IGK 4.5087736 0.40269721     1898 0.5973028 4.043917e-05
#> IGL 4.7761543 0.28333416      784 0.7166658 1.851338e-04
#> TRA 3.7682140 0.07196974       58 0.9280303 1.398601e-02
#> TRB 3.8933793 0.11402336       81 0.8859766 9.174312e-03
#> TRD 0.5004024 0.27807191        2 0.7219281 5.000000e-01
#> TRG        NA         NA       NA        NA           NA
#> 
#> $sample_03
#>     diversity clonality richness  evenness       median
#> IGH 3.3401373 0.5400036     1424 0.4599964 1.032684e-04
#> IGK 5.4716100 0.1767547      770 0.8232453 4.581552e-04
#> IGL 2.5747289 0.6218047      905 0.3781953 6.578731e-05
#> TRA 4.0981274 0.1194323      105 0.8805677 5.917160e-03
#> TRB 3.9120015 0.2282353      159 0.7717647 2.816901e-03
#> TRD        NA        NA       NA        NA           NA
#> TRG 0.5982696 0.1368794        2 0.8631206 5.000000e-01

all_sample_all_chain_all_metrics_wide_format_dataframe <- all_sample_all_chain_all_metrics_wide_format_dataframe_list %>%
    combine_all_sample_repertoire_metrics

all_sample_all_chain_all_metrics_wide_format_dataframe
#>    sample_name item_name diversity  clonality richness  evenness       median
#> 1    sample_01       IGH 5.4161872 0.26283295     1552 0.7371670 1.509510e-04
#> 2    sample_01       IGK 5.2677388 0.28931127     1656 0.7106887 9.082240e-05
#> 3    sample_01       IGL 4.8949171 0.25490053      713 0.7450995 4.132231e-04
#> 4    sample_01       TRA 4.3018929 0.06585582      100 0.9341442 6.437768e-03
#> 5    sample_01       TRB 4.8358496 0.08467479      197 0.9153252 3.642987e-03
#> 6    sample_01       TRD 0.6730117 0.02904941        2 0.9709506 5.000000e-01
#> 7    sample_01       TRG 0.6931472 0.00000000        2 1.0000000 5.000000e-01
#> 8    sample_02       IGH 5.3401961 0.28075859     1677 0.7192414 9.231905e-05
#> 9    sample_02       IGK 4.5087736 0.40269721     1898 0.5973028 4.043917e-05
#> 10   sample_02       IGL 4.7761543 0.28333416      784 0.7166658 1.851338e-04
#> 11   sample_02       TRA 3.7682140 0.07196974       58 0.9280303 1.398601e-02
#> 12   sample_02       TRB 3.8933793 0.11402336       81 0.8859766 9.174312e-03
#> 13   sample_02       TRD 0.5004024 0.27807191        2 0.7219281 5.000000e-01
#> 14   sample_02       TRG        NA         NA       NA        NA           NA
#> 15   sample_03       IGH 3.3401373 0.54000361     1424 0.4599964 1.032684e-04
#> 16   sample_03       IGK 5.4716100 0.17675466      770 0.8232453 4.581552e-04
#> 17   sample_03       IGL 2.5747289 0.62180471      905 0.3781953 6.578731e-05
#> 18   sample_03       TRA 4.0981274 0.11943225      105 0.8805677 5.917160e-03
#> 19   sample_03       TRB 3.9120015 0.22823526      159 0.7717647 2.816901e-03
#> 20   sample_03       TRD        NA         NA       NA        NA           NA
#> 21   sample_03       TRG 0.5982696 0.13687943        2 0.8631206 5.000000e-01

all_sample_all_chain_individual_metrics_dataframe_list <- all_sample_all_chain_all_metrics_wide_format_dataframe %>%
    get_item_name_x_sample_name_for_each_metric

all_sample_all_chain_individual_metrics_dataframe_list
#> $diversity
#>     sample_01 sample_02 sample_03
#> IGH 5.4161872 5.3401961 3.3401373
#> IGK 5.2677388 4.5087736 5.4716100
#> IGL 4.8949171 4.7761543 2.5747289
#> TRA 4.3018929 3.7682140 4.0981274
#> TRB 4.8358496 3.8933793 3.9120015
#> TRD 0.6730117 0.5004024        NA
#> TRG 0.6931472        NA 0.5982696
#> 
#> $clonality
#>      sample_01  sample_02 sample_03
#> IGH 0.26283295 0.28075859 0.5400036
#> IGK 0.28931127 0.40269721 0.1767547
#> IGL 0.25490053 0.28333416 0.6218047
#> TRA 0.06585582 0.07196974 0.1194323
#> TRB 0.08467479 0.11402336 0.2282353
#> TRD 0.02904941 0.27807191        NA
#> TRG 0.00000000         NA 0.1368794
#> 
#> $richness
#>     sample_01 sample_02 sample_03
#> IGH      1552      1677      1424
#> IGK      1656      1898       770
#> IGL       713       784       905
#> TRA       100        58       105
#> TRB       197        81       159
#> TRD         2         2        NA
#> TRG         2        NA         2
#> 
#> $evenness
#>     sample_01 sample_02 sample_03
#> IGH 0.7371670 0.7192414 0.4599964
#> IGK 0.7106887 0.5973028 0.8232453
#> IGL 0.7450995 0.7166658 0.3781953
#> TRA 0.9341442 0.9280303 0.8805677
#> TRB 0.9153252 0.8859766 0.7717647
#> TRD 0.9709506 0.7219281        NA
#> TRG 1.0000000        NA 0.8631206
#> 
#> $median
#>        sample_01    sample_02    sample_03
#> IGH 0.0001509510 9.231905e-05 1.032684e-04
#> IGK 0.0000908224 4.043917e-05 4.581552e-04
#> IGL 0.0004132231 1.851338e-04 6.578731e-05
#> TRA 0.0064377682 1.398601e-02 5.917160e-03
#> TRB 0.0036429872 9.174312e-03 2.816901e-03
#> TRD 0.5000000000 5.000000e-01           NA
#> TRG 0.5000000000           NA 5.000000e-01
```

### Calculate and merge repertoire metrics by IGH isotypes for each sample in the list

This step consists of three functions.

``` r
# handle repertoire metrics all all the isotypes of IGH chain.
all_sample_IGH_chain_all_metrics_wide_format_dataframe_list <- the_divergent_clonotype_dataframe_list %>%
    lapply(., calculate_IGH_isotype_proportion)

all_sample_IGH_chain_all_metrics_wide_format_dataframe_list
#> $sample_01
#>      count   proportion
#> IGHA   202 0.1828054299
#> IGHD     1 0.0009049774
#> IGHG   813 0.7357466063
#> IGHM    89 0.0805429864
#> 
#> $sample_02
#>      count   proportion
#> IGHA    11 0.0080941869
#> IGHD     1 0.0007358352
#> IGHG  1074 0.7902869757
#> IGHM   273 0.2008830022
#> 
#> $sample_03
#>      count  proportion
#> IGHA   416 0.343517754
#> IGHD     4 0.003303055
#> IGHG   775 0.639966969
#> IGHM    16 0.013212221

all_sample_IGH_chain_all_metrics_wide_format_dataframe <- all_sample_IGH_chain_all_metrics_wide_format_dataframe_list %>%
    combine_all_sample_repertoire_metrics

all_sample_IGH_chain_all_metrics_wide_format_dataframe
#>    sample_name item_name count   proportion
#> 1    sample_01      IGHA   202 0.1828054299
#> 2    sample_01      IGHD     1 0.0009049774
#> 3    sample_01      IGHG   813 0.7357466063
#> 4    sample_01      IGHM    89 0.0805429864
#> 5    sample_02      IGHA    11 0.0080941869
#> 6    sample_02      IGHD     1 0.0007358352
#> 7    sample_02      IGHG  1074 0.7902869757
#> 8    sample_02      IGHM   273 0.2008830022
#> 9    sample_03      IGHA   416 0.3435177539
#> 10   sample_03      IGHD     4 0.0033030553
#> 11   sample_03      IGHG   775 0.6399669694
#> 12   sample_03      IGHM    16 0.0132122213

all_sample_IGH_chain_individual_metrics_dataframe_list <- all_sample_IGH_chain_all_metrics_wide_format_dataframe %>%
    get_item_name_x_sample_name_for_each_metric

all_sample_IGH_chain_individual_metrics_dataframe_list
#> $count
#>      sample_01 sample_02 sample_03
#> IGHA       202        11       416
#> IGHD         1         1         4
#> IGHG       813      1074       775
#> IGHM        89       273        16
#> 
#> $proportion
#>         sample_01    sample_02   sample_03
#> IGHA 0.1828054299 0.0080941869 0.343517754
#> IGHD 0.0009049774 0.0007358352 0.003303055
#> IGHG 0.7357466063 0.7902869757 0.639966969
#> IGHM 0.0805429864 0.2008830022 0.013212221
```

## Clonotype repertoire metrics formulas

The repertoire metrics formula including richness, diversity (Shannon
entropy), evenness (Pielou’s eveness), clonality, and median (frequency
median) were defined as follows, where
![p_i](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;p_i "p_i")
is the frequency of
![{\\rm clonotype}\_i](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%7B%5Crm%20clonotype%7D_i "{\rm clonotype}_i")
in a sample with
![N](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;N "N")
unique clonotypes ([Khunger, Rytlewski et
al. 2019](https://www.tandfonline.com/doi/full/10.1080/2162402X.2019.1652538),
[Looney, Topacio-Hall et
al. 2020](https://www.frontiersin.org/articles/10.3389/fimmu.2019.02985/full)).
![P](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;P "P")
is the frequency vector of unique clonotypes in a sample.

![
richness\\ =\\ N
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0Arichness%5C%20%3D%5C%20N%0A "
richness\ =\ N
")

![
Shannon\\ entropy=-\\sum\_{i=1}^{N}{p_i\\log_2{\\left(p_i\\right)}}
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0AShannon%5C%20entropy%3D-%5Csum_%7Bi%3D1%7D%5E%7BN%7D%7Bp_i%5Clog_2%7B%5Cleft%28p_i%5Cright%29%7D%7D%0A "
Shannon\ entropy=-\sum_{i=1}^{N}{p_i\log_2{\left(p_i\right)}}
")

![
Pielou\\prime s\\ eveness\\ =\\ \\frac{Shannon\\ entropy}{\\log_2{N}}
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0APielou%5Cprime%20s%5C%20eveness%5C%20%3D%5C%20%5Cfrac%7BShannon%5C%20entropy%7D%7B%5Clog_2%7BN%7D%7D%0A "
Pielou\prime s\ eveness\ =\ \frac{Shannon\ entropy}{\log_2{N}}
")

![
clonality\\ =\\ 1\\ -\\ Pielou\\prime s\\ evenness
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0Aclonality%5C%20%3D%5C%201%5C%20-%5C%20Pielou%5Cprime%20s%5C%20evenness%0A "
clonality\ =\ 1\ -\ Pielou\prime s\ evenness
")

![
frequency\\ median\\ =\\ median(P)
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0Afrequency%5C%20median%5C%20%3D%5C%20median%28P%29%0A "
frequency\ median\ =\ median(P)
")

The function `calculate_repertoire_metrics` is essential to implement
the repertoire metrics formulas

``` r
calculate_repertoire_metrics
#> function (named_species_vector) 
#> {
#>     stopifnot(!duplicated(names(named_species_vector)))
#>     species_vector <- named_species_vector
#>     frequency_vector <- species_vector/sum(species_vector)
#>     shannon_entropy <- -sum(frequency_vector * log(frequency_vector), 
#>         na.rm = TRUE)
#>     richness_count <- length(species_vector)
#>     pielou_evenness <- shannon_entropy/log(richness_count)
#>     clonality_score <- 1 - pielou_evenness
#>     frequency_median <- median(frequency_vector)
#>     output_vector <- c(shannon_entropy, clonality_score, richness_count, 
#>         pielou_evenness, frequency_median)
#>     names(output_vector) <- c("diversity", "clonality", "richness", 
#>         "evenness", "median")
#>     output_vector
#> }
#> <bytecode: 0x00000000285a2908>
#> <environment: namespace:rTCRBCRr>
```

## Acknowledgements

The [hexagon](https://github.com/terinjokes/StickersStandard) logo of
the package was created with the help of the package
[hexSticker](https://github.com/GuangchuangYu/hexSticker). The math
formula was written with the help of recognition tool
[MyScript](https://webdemo.myscript.com/). The latex formula in markdown
was inspired by [rmd4sci](https://rmd4sci.njtierney.com/math). The code
in this study was inspired by the [UCSB R tutorial
note](http://traits-dgs.nceas.ucsb.edu/workspace/r/r-tutorial-for-measuring-species-diversity/Measuring%20Diversity%20in%20R.pdf/attachment_download/file),
[LymphoSeq script](https://rdrr.io/bioc/LymphoSeq/src/R/clonality.R),
and [vegan package](https://cran.r-project.org/package=vegan).
