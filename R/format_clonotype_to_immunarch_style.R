#' Parse mixcr format
#'
#' @param input_clone_dataframe Generated from mixcr program
#'
#' @return A dataframe of immunarch format
#' @import magrittr
#'
parse_mixcr <- function(input_clone_dataframe) {

    immunarch_header_names <- c("Clones", "Proportion", "CDR3.nt",
                                "CDR3.aa", "V.name", "D.name",
                                "J.name", "V.end", "D.start",
                                "D.end", "J.start", "VJ.ins",
                                "VD.ins", "DJ.ins", "Sequence",
                                "C.name")

    empty_immunarch_dataframe <- rep(NA, times = length(immunarch_header_names)) %>%
        as.list %>%
        magrittr::set_names(., value = immunarch_header_names) %>%
        as.data.frame %>%
        .[-1, ]

    if (nrow(input_clone_dataframe) == 0) {
        formatted_dataframe <- empty_immunarch_dataframe
    } else {
        # immune_data_list <- repLoad(input_path)
        # formatted_dataframe <- immune_data_list$data[[1]]

        # Replace empty V.name, D.name, and J.name with * for downstream processing.
        formatted_dataframe <- data.frame(
            Clones = input_clone_dataframe$cloneCount,
            Proportion = input_clone_dataframe$cloneFraction,
            CDR3.nt = input_clone_dataframe$nSeqCDR3,
            CDR3.aa = input_clone_dataframe$aaSeqCDR3,
            V.name = input_clone_dataframe$allVHitsWithScore %>% replace(., (. == "") | is.na(.), "*"),
            D.name = input_clone_dataframe$allDHitsWithScore %>% replace(., (. == "") | is.na(.), "*"),
            J.name = input_clone_dataframe$allJHitsWithScore %>% replace(., (. == "") | is.na(.), "*"),
            V.end = rep(NA, times = nrow(input_clone_dataframe)),
            D.start = rep(NA, times = nrow(input_clone_dataframe)),
            D.end  = rep(NA, times = nrow(input_clone_dataframe)),
            J.start = rep(NA, times = nrow(input_clone_dataframe)),
            VJ.ins = rep(NA, times = nrow(input_clone_dataframe)),
            VD.ins  = rep(NA, times = nrow(input_clone_dataframe)),
            DJ.ins = rep(NA, times = nrow(input_clone_dataframe)),
            Sequence = rep(NA, times = nrow(input_clone_dataframe)),
            C.name = input_clone_dataframe$allCHitsWithScore %>% replace(., (. == "") | is.na(.), "*")
        )
    }

    formatted_dataframe
}


#' Parse trust4 format
#'
#' @param input_clone_dataframe Generated from trust4 program
#'
#' @return A dataframe of immunarch format
#' @import magrittr
#' @importFrom stats setNames
#'
parse_trust4 <- function(input_clone_dataframe) {

    # Ensure the column names are not changed in the future trust4 version.
    stopifnot(
        colnames(input_clone_dataframe)[1:8] == c("#count", "frequency", "CDR3nt", "CDR3aa", "V", "D", "J", "C")
    )

    raw_format_dataframe <- input_clone_dataframe %>%
        .[, c("#count", "frequency", "CDR3nt", "CDR3aa", "V", "D", "J"), drop = F] %>%
        setNames(., c("Clones", "Proportion", "CDR3.nt", "CDR3.aa", "V.name", "D.name", "J.name"))

    C_name_dataframe <- input_clone_dataframe[, "C", drop = F] %>%
        setNames(., "C.name")

    input_clone_dataframe_row_number <- nrow(input_clone_dataframe)

    other_immunarch_field_dataframe <- data.frame(
        V.end = rep(NA, times = input_clone_dataframe_row_number),
        D.start = rep(NA, times = input_clone_dataframe_row_number),
        D.end = rep(NA, times = input_clone_dataframe_row_number),
        J.start = rep(NA, times = input_clone_dataframe_row_number),
        VJ.ins = rep(NA, times = input_clone_dataframe_row_number),
        VD.ins = rep(NA, times = input_clone_dataframe_row_number),
        DJ.ins = rep(NA, times = input_clone_dataframe_row_number),
        Sequence = rep(NA, times = input_clone_dataframe_row_number)
    )

    formatted_dataframe <- cbind.data.frame(
        raw_format_dataframe,
        other_immunarch_field_dataframe,
        C_name_dataframe
    )

    formatted_dataframe
}


#' Convert clonotype dataframe to immunarch format
#'
#' @param input_dataframe a clonotype dataframe from an upstream clonotyping tool
#' @param clonotyping_tool choose from c("mixcr, "trust")
#' @import magrittr
#' @return a clonotype dataframe of immunarch format
#' @export
#' @examples
#' format_clonotype_to_immunarch_style(raw_input_clonotype_dataframe, "trust")
#'
format_clonotype_to_immunarch_style <- function(input_dataframe, clonotyping_tool) {
    # Immunarch data format https://immunarch.com/articles/v2_data.html
    # immunarch comes with its own data format, including tab-delimited columns that can be specified as follows:
    # "Clones" - count or number of barcodes (events, UMIs) or reads;
    # "Proportion" - proportion of barcodes (events, UMIs) or reads;
    # "CDR3.nt" - CDR3 nucleotide sequence;
    # "CDR3.aa" - CDR3 amino acid sequence;
    # "V.name" - names of aligned Variable gene segments;
    # "D.name" - names of aligned Diversity gene segments or NA;
    # "J.name" - names of aligned Joining gene segments;
    # "V.end" - last positions of aligned V gene segments (1-based);
    # "D.start" - positions of D’5 end of aligned D gene segments (1-based);
    # "D.end" - positions of D’3 end of aligned D gene segments (1-based);
    # "J.start" - first positions of aligned J gene segments (1-based);
    # "VJ.ins" - number of inserted nucleotides (N-nucleotides) at V-J junction (-1 for receptors with VDJ recombination);
    # "VD.ins" - number of inserted nucleotides (N-nucleotides) at V-D junction (-1 for receptors with VJ recombination);
    # "DJ.ins" - number of inserted nucleotides (N-nucleotides) at D-J junction (-1 for receptors with VJ recombination);
    # "Sequence" - full nucleotide sequence.

    if (clonotyping_tool == "mixcr") {
        formatted_dataframe <- parse_mixcr(input_dataframe)
    }

    if (clonotyping_tool == "trust") {
        formatted_dataframe <- parse_trust4(input_dataframe)
    }

    formatted_dataframe
}
