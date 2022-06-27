#' calculate_repertoire_metrics
#'
#' @param named_species_vector a named vector
#' @return a named vector
#' @importFrom stats median
#' @export
#' @examples
#' a_named_vector <- c("apple" = 1, "banana" = 3, "cranberry" = 7, "date" = 10)
#' calculate_repertoire_metrics(a_named_vector)
#'
calculate_repertoire_metrics <- function(named_species_vector) {

    # Calculate the repertoire metrics from a named species vector

    stopifnot(!duplicated(names(named_species_vector)))

    # How does the named_species_vector look like?
    # named_species_vector <- c(10, 6, 3)
    # names(named_species_vector) <- c("apple", "pear", "banana")

    species_vector <- named_species_vector

    frequency_vector <- species_vector/sum(species_vector)
    shannon_entropy <- -sum(frequency_vector * log(frequency_vector), na.rm = TRUE)
    richness_count <- length(species_vector)
    pielou_evenness <- shannon_entropy/log(richness_count)
    clonality_score <- 1 - pielou_evenness
    frequency_median <- median(frequency_vector)

    # The variable name in the output_vector is more scientific to reveal the underlying formula

    output_vector <- c(shannon_entropy, clonality_score, richness_count, pielou_evenness, frequency_median)
    names(output_vector) <- c("diversity", "clonality", "richness", "evenness", "median")

    output_vector
}


#' summarize_repertoire_metrics
#'
#' @param one_sample_dataframe a dataframe of clonotype in immunarch format
#' @return a named vector
#'
summarize_repertoire_metrics <- function(one_sample_dataframe) {

    # one_sample_dataframe can be a table of immunarch clone format of one sample

    if (nrow(one_sample_dataframe) <= 1) {
        metrics_vector <- rep(NA, times = 5)
        names(metrics_vector) <- c("diversity", "clonality", "richness", "evenness", "median")
    } else {
        species_name_column <- "CDR3.aa"
        species_count_column <- "Clones"
        one_sample_named_species_vector <- one_sample_dataframe[, species_count_column, drop = T]
        names(one_sample_named_species_vector) <- one_sample_dataframe[, species_name_column, drop = T]

        metrics_vector <- calculate_repertoire_metrics(one_sample_named_species_vector)
    }

    metrics_vector
}


#' compute_repertoire_metrics_by_chain_name
#'
#' @param input_dataframe a clonotype dataframe with chain name information
#'
#' @return repertoire metrics by chain name.
#' @export
#' @examples
#' compute_repertoire_metrics_by_chain_name(convergent_clonotype_merged_dataframe)
#'
compute_repertoire_metrics_by_chain_name <- function(input_dataframe) {
    input_dataframe$chain_name <- factor(input_dataframe$chain_name,
                                         levels = c("IGH", "IGK", "IGL", "TRA", "TRB", "TRD", "TRG"))
    
    # There is no need to correct proportion based on clones for each chain name,
    # because repertoire metrics calculation only needs the CDR3.aa and Clones columns.
    
    split_metrics_list <- split(
        input_dataframe,
        list(input_dataframe$chain_name)
    )
    
    summarized_metrics_list <- lapply(split_metrics_list, summarize_repertoire_metrics)
    summarized_metrics_matrix <- do.call(rbind, summarized_metrics_list)
    summarized_metrics_dataframe <- as.data.frame(summarized_metrics_matrix)

    summarized_metrics_dataframe
}
