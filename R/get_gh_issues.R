#' @title Get issues information from GitHub for the given time period.
#'
#' @description Get information on issues from the specified GitHub
#'   repository. This is a wrapper around the 'gh' package. Original code taken
#'   from <https://github.com/jennybc/analyze-github-stuff-with-r/>.
#'
#' @param owner String specifying the owner of the repository.
#' @param repo String specifying the name of the repo.
#' @param start_date String specifying start date of reporting period to filter
#'   by, in the format `YYYY-MM-DD`. `NULL` by default, where no filters will be
#'   applied.
#' @param end_date String specifying end date of reporting period to filter by,
#'   in the format `YYYY-MM-DD`. `NULL` by default, where no filters will be
#'   applied.
#'
#' @import gh
#' @import purrr
#'
#' @examples
#' \donttest{
#' get_gh_issues(owner = "martinctc", repo = "rwa")
#' }
#'
#' @export

get_gh_issues <- function(owner, repo, start_date = NULL, end_date = NULL){

  query_str <- paste0("https://api.github.com/repos/",
                      owner, "/",
                      repo,
                      "/issues")

  res <- httr::GET(url = query_str,
                   query = list(
                     state = "all",
                     per_page = 100,
                     page = 1
                   ))

  jsondata <- httr::content(res, type = "text")

  iss_df <-
    jsonlite::fromJSON(jsondata, flatten = TRUE) %>%
    dplyr::as_tibble() %>%
    mutate(
      across(
        .cols = c(
          "created_at",
          "updated_at",
          "closed_at"
          ),
        .fns = ~as.Date(.)
      )
    )


  # gh_issues <-
  #   gh(
  #     endpoint = "GET /issues",
  #     owner = owner,
  #     repo = repo,
  #     state = "all",
  #     .limit = Inf
  #   )
  #
  # iss_df <-
  #   gh_issues %>%
  #   {
  #     dplyr::tibble(
  #       number = map_int(., "number"),
  #       title = map_chr(., "title"),
  #       assignee = map_chr(., c("assignee", "login")),
  #       state = map_chr(., "state"),
  #       created_at = map_chr(., "created_at") %>% as.Date(),
  #       closed_at = map_chr_hack(., "closed_at") %>% as.Date(),
  #       html_url = map_chr(., "html_url")
  #     )
  #   }

  if(!is.null(start_date) & !is.null(end_date)){

    iss_df %>%
      filter(
        between(created_at, as.Date(start_date, "%Y-%m-%d"), as.Date(end_date, "%Y-%m-%d")) |
          between(closed_at, as.Date(start_date, "%Y-%m-%d"), as.Date(end_date, "%Y-%m-%d"))
      )

  } else {

    iss_df

  }
}
