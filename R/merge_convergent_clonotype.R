#' summarize_convergence_function
#'
#' @param a_dataframe a dataframe
#' @return a dataframe
#' @import magrittr
#'
summarize_convergence_function <- function(a_dataframe) {
    # A CDR3.aa might have different CDR3.nt, V.name, D.name, J.name, or isotype_name
    # Select the most frequent elements.
    processed_vector <- with(
        a_dataframe, {
            c(
                Clones = Clones %>% sum %>% as.character,
                Proportion = Proportion %>% sum %>% as.character,
                CDR3.nt = CDR3.nt[which.max(Clones)],
                CDR3.aa = CDR3.aa %>% unique,
                V.name = V.name[which.max(Clones)],
                D.name = D.name[which.max(Clones)],
                J.name = J.name[which.max(Clones)],
                V.end = NA,
                D.start = NA,
                D.end = NA,
                J.start = NA,
                VJ.ins = NA,
                VD.ins = NA,
                DJ.ins = NA,
                Sequence = NA,
                chain_name = chain_name %>% unique,
                isotype_name = ifelse(
                    all(is.na(isotype_name)),
                    NA,
                    isotype_name[!is.na(isotype_name)][which.max(Clones[!is.na(isotype_name)])]
                )
            )
        }
    )
    processed_vector
}

#' Merge convergent clonotype
#'
#' @param input_dataframe A dataframe of clonotype of immunarch format
#' @return A dataframe of clonotype of immunarch format
#' merge_convergent_clonotype_function(an_immunarch_format_clonotype_dataframe)
#' @import magrittr
#' @export
#' @examples
#' merge_convergent_clonotype(chain_separated_dataframe)
#'
merge_convergent_clonotype <- function(input_dataframe) {

    if (nrow(input_dataframe) == 0) {
        ouput_dataframe <- input_dataframe
    } else {
        CDR3aa_chain_combination_list <- split(
            input_dataframe,
            list(input_dataframe$CDR3.aa, input_dataframe$chain_name),
            drop = T
        )

        # df1 <- CDR3aa_chain_combination_list[["CQKYNSAPRTF.IGK"]]
        # df2 <- CDR3aa_chain_combination_list[["CAGRYGGNSYYFDYW.IGH"]]
        # df3 <- CDR3aa_chain_combination_list[["CARAAAYCGGDCSLSWFDPW.IGH"]]
        summarized_convergence_list <- lapply(CDR3aa_chain_combination_list, summarize_convergence_function)

        # Ensure each processed vector is identical.
        stopifnot(length(unique(lapply(summarized_convergence_list, names))) == 1)
        stopifnot(length(unique(lapply(summarized_convergence_list, length))) == 1)

        summarized_convergence_dataframe <- do.call(rbind, summarized_convergence_list) %>%
            as.data.frame %>%
            inset(., "Clones", value = as.numeric(.$Clones)) %>%
            inset(., "Proportion", value = as.numeric(.$Proportion))

        output_dataframe <- summarized_convergence_dataframe %>%
            calibrate_proportion_by_clones %>%
            magrittr::set_rownames(., value = NULL)
    }

    output_dataframe
}
