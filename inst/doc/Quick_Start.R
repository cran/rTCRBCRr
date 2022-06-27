## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----example------------------------------------------------------------------
library("rTCRBCRr")
library("magrittr")
library("readr")

## ----message=FALSE, warning=FALSE---------------------------------------------
present_tool <- c("trust", "mixcr")[1]
example_data_directory <- system.file(paste("extdata", present_tool, sep = "/"), package = "rTCRBCRr")
input_paths <- dir(example_data_directory, full.names = TRUE)
input_files <- dir(example_data_directory, full.names = FALSE)
input_files

sample_names <- sub(".tsv.*", "", input_files)
sample_names

raw_clonotype_dataframe_list <- lapply(input_paths, readr::read_tsv) %>%
    magrittr::set_names(., value = sample_names)
raw_clonotype_dataframe_list

## -----------------------------------------------------------------------------
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

## -----------------------------------------------------------------------------
# handle repertoire metrics for all the chains.
all_sample_all_chain_all_metrics_wide_format_dataframe_list <- the_divergent_clonotype_dataframe_list %>%
    lapply(., compute_repertoire_metrics_by_chain_name)

all_sample_all_chain_all_metrics_wide_format_dataframe_list

all_sample_all_chain_all_metrics_wide_format_dataframe <- all_sample_all_chain_all_metrics_wide_format_dataframe_list %>%
    combine_all_sample_repertoire_metrics

all_sample_all_chain_all_metrics_wide_format_dataframe

all_sample_all_chain_individual_metrics_dataframe_list <- all_sample_all_chain_all_metrics_wide_format_dataframe %>%
    get_item_name_x_sample_name_for_each_metric

all_sample_all_chain_individual_metrics_dataframe_list

## -----------------------------------------------------------------------------
# handle repertoire metrics all all the isotypes of IGH chain.
all_sample_IGH_chain_all_metrics_wide_format_dataframe_list <- the_divergent_clonotype_dataframe_list %>%
    lapply(., calculate_IGH_isotype_proportion)

all_sample_IGH_chain_all_metrics_wide_format_dataframe_list

all_sample_IGH_chain_all_metrics_wide_format_dataframe <- all_sample_IGH_chain_all_metrics_wide_format_dataframe_list %>%
    combine_all_sample_repertoire_metrics

all_sample_IGH_chain_all_metrics_wide_format_dataframe

all_sample_IGH_chain_individual_metrics_dataframe_list <- all_sample_IGH_chain_all_metrics_wide_format_dataframe %>%
    get_item_name_x_sample_name_for_each_metric

all_sample_IGH_chain_individual_metrics_dataframe_list

## -----------------------------------------------------------------------------
calculate_repertoire_metrics

