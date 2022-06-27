#' combine_all_sample_repertoire_metrics
#'
#' @param input_dataframe_list a list of dataframes with repertoire metrics by chain name
#'
#' @return a wide table with all samples' all chains' all repertoire metrics
#' @export
#' @examples
#' combine_all_sample_repertoire_metrics(all_sample_all_chain_all_metrics_wide_format_dataframe_list)
#' combine_all_sample_repertoire_metrics(all_sample_IGH_chain_all_metrics_wide_format_dataframe_list)
#'
combine_all_sample_repertoire_metrics <- function(input_dataframe_list) {

    if (is.null(names(input_dataframe_list))) {
        stop("The input dataframe list must have names as sample names")
    }

    output_dataframe_list <- list()

    for (sample_name in names(input_dataframe_list)) {
        current_input_dataframe <- input_dataframe_list[[sample_name]]

        item_name <- rownames(current_input_dataframe)
        current_output_dataframe <- cbind(sample_name, item_name, current_input_dataframe)

        output_dataframe_list[[sample_name]] <- current_output_dataframe
    }

    output_combined_dataframe <- do.call(rbind, output_dataframe_list)
    rownames(output_combined_dataframe) <- NULL

    output_combined_dataframe

    # Tidyverse style code, abandoned.
    # output_combined_dataframe <- input_dataframe_list %>%
    #     purrr::map(., ~ tibble::rownames_to_column(.x, var = "item_name")) %>%
    #     purrr::imap(., ~ tibble::add_column(.x, sample_name = .y, .before = 1)) %>%
    #     dplyr::bind_rows(.)
    # output_combined_dataframe
}
