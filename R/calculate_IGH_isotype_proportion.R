#' calculate_IGH_isotype_proportion
#'
#' @param input_dataframe a clonotype dataframe with chain name and isotype name information
#'
#' @return a dataframe of count and proportion of isotypes of IGH chain.
#' @export
#' @examples
#' calculate_IGH_isotype_proportion(convergent_clonotype_merged_dataframe)
#'
calculate_IGH_isotype_proportion <- function(input_dataframe) {

    desired_row_index <- input_dataframe$chain_name == "IGH" & !is.na(input_dataframe$isotype_name)
    filtered_dataframe <- input_dataframe[desired_row_index, , drop = F]

    isotype_vector <- factor(filtered_dataframe$isotype_name, levels = c("IGHA", "IGHD", "IGHG", "IGHM"))

    isotype_count_table <- table(isotype_vector)
    isotype_count_dataframe <- as.data.frame(isotype_count_table)
    colnames(isotype_count_dataframe) <- c("isotype_name", "count")

    isotype_proportion_table <- prop.table(table(isotype_vector))
    isotype_proportion_dataframe <- as.data.frame(isotype_proportion_table)
    colnames(isotype_proportion_dataframe) <- c("isotype_name", "proportion")

    merged_isotype_dataframe <- merge(
        isotype_count_dataframe,
        isotype_proportion_dataframe,
        by = "isotype_name"
    )

    rownames(merged_isotype_dataframe) <- merged_isotype_dataframe$isotype_name
    merged_isotype_dataframe$isotype_name <- NULL

    merged_isotype_dataframe
}
