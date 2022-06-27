#' Clean the clonotype dataframe
#'
#' @param input_dataframe A dataframe of clonotype of immunarch format
#' @return A dataframe of clonotype of immunarch format
#' @export
#' @examples
#' remove_nonproductive_CDR3aa(immunarch_style_dataframe)
#'
remove_nonproductive_CDR3aa <- function(input_dataframe) {
    # get the index that are not desired when we want productive CD3R.aa only.

    undesired_pattern <- "\\*|_|partial|out_of_frame|\\?"
    desired_index <- !grepl(pattern = undesired_pattern, input_dataframe$CDR3.aa)

    # i_1 <- grepl(pattern = "\\*", input_dataframe$CDR3.aa) # mixcr filter
    # i_2 <- grepl(pattern = "_", input_dataframe$CDR3.aa) # mixcr filter
    # i_3 <- input_dataframe$CDR3.aa == "partial" # trust filter
    # i_4 <- input_dataframe$CDR3.aa == "out_of_frame" # trust filter
    # i_5 <- grepl(pattern = "_", input_dataframe$CDR3.aa) # trust filter
    # i_6 <- grepl(pattern = "\\?", input_dataframe$CDR3.aa) # trust filter

    # desired_index <- !(i_1 | i_2 | i_3 | i_4 | i_5 | i_6)

    filtered_dataframe <- input_dataframe[desired_index, ]

    proportion_corrected_dataframe <- calibrate_proportion_by_clones(filtered_dataframe)
    rownames(proportion_corrected_dataframe) <- NULL

    proportion_corrected_dataframe

}
