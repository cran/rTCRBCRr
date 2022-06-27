#' Annotate chain name and isotype name
#'
#' @param input_dataframe A dataframe of clonotype of immunarch format
#' @return A dataframe of clonotype of immunarch format
#' @import magrittr
#' @export
#' @examples
#' annotate_chain_name_and_isotype_name(nonproductive_CDR3aa_removed_dataframe)
#'
annotate_chain_name_and_isotype_name <- function(input_dataframe) {


    # Prepare a function to handle TCR and BCR chains.
    # remove the sub-chain from the VDJ name fields.
    # remove TCR gene sub-tag, like this: TRBV7-9*01 to TRBV7-9

    cleaner_clone_dataframe <- input_dataframe

    cleaner_clone_dataframe$V.name <- gsub("\\*.+", replacement = "", input_dataframe$V.name)
    cleaner_clone_dataframe$D.name <- gsub("\\*.+", replacement = "", input_dataframe$D.name)
    cleaner_clone_dataframe$J.name <- gsub("\\*.+", replacement = "", input_dataframe$J.name)


    # remove the * or . from the VDJ names, so that only chain name types are retained.
    derived_chain_labels <- cleaner_clone_dataframe %>%
        .[, c("V.name", "D.name", "J.name")] %>%
        apply(., MARGIN = 1, function(x) substr(x, 1, 3)) %>%
        t %>%
        apply(., MARGIN = 1, function(x) x[!grepl("\\*|\\.", x)] %>% unique)

    # remove the conflicting non-unique chains in a clone.
    if (inherits(derived_chain_labels, "list")) {
        unique_chain_index <- sapply(derived_chain_labels, length) == 1
        unique_chain_labels <- derived_chain_labels[unique_chain_index] %>% unlist
        prudential_dataframe <- cleaner_clone_dataframe[unique_chain_index, ]
    } else {
        unique_chain_labels <- derived_chain_labels
        prudential_dataframe <- cleaner_clone_dataframe
    }
    # Ensure the multiple chain in one clone case is eliminated from the data frame.
    stopifnot(nrow(prudential_dataframe) == length(unique_chain_labels))

    isotype_labels <- prudential_dataframe$C.name %>%
        replace(., . == ".", NA) %>%
        replace(., . == "*", NA) %>%
        gsub(pattern = "\\*.+", replacement = "", x = .) %>%
        gsub(pattern = "\\d+", replacement = "", x = .)

    # Annotate chain names and cell type names
    labelled_dataframe <- prudential_dataframe %>%
        inset(., "C.name", value = NULL) %>%
        inset(., "chain_name", value = unique_chain_labels) %>%
        inset(., "isotype_name", value = isotype_labels) %>%
        calibrate_proportion_by_clones %>%
        magrittr::set_rownames(., value = NULL)

    labelled_dataframe
}
