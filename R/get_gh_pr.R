#' @title Get pull request information from GitHub for the given time period.
#'
#' @description Get information on pull requests from the specified GitHub
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
#' get_gh_pr(owner = "martinctc", repo = "rwa")
#' }
#'
#' @export
get_gh_pr <- function(owner, repo, start_date = NULL, end_date = NULL){

  pr_list <-
    gh("/repos/:owner/:repo/pulls", owner = owner, repo = repo,
       state = "all", .limit = Inf)

  pr_df <- pr_list %>%
    {
      dplyr::tibble(
        number = map_int(., "number"),
        id = map_int(., "id"),
        title = map_chr(., "title"),
        state = map_chr(., "state"),
        user = map_chr(., c("user", "login")),
        commits_url = map_chr(., "commits_url"),
        diff_url = map_chr(., "diff_url"),
        patch_url = map_chr(., "patch_url"),
        merge_commit_sha = map_chr_hack(., "merge_commit_sha"),
        pr_HEAD_label = map_chr(., c("head", "label")),
        pr_HEAD_sha = map_chr(., c("head", "sha")),
        pr_base_label = map_chr(., c("base", "label")),
        pr_base_sha = map_chr(., c("base", "sha")),
        created_at = map_chr(., "created_at") %>% as.Date(),
        closed_at = map_chr_hack(., "closed_at") %>% as.Date(),
        merged_at = map_chr_hack(., "merged_at") %>% as.Date())
    }

  if(!is.null(start_date) & !is.null(end_date)){

    pr_df %>%
      filter(
        between(created_at, as.Date(start_date, "%Y-%m-%d"), as.Date(end_date, "%Y-%m-%d")) |
          between(closed_at, as.Date(start_date, "%Y-%m-%d"), as.Date(end_date, "%Y-%m-%d")) |
          between(merged_at, as.Date(start_date, "%Y-%m-%d"), as.Date(end_date, "%Y-%m-%d"))
      )

  } else {

    pr_df

  }
}

map_chr_hack <- function(.x, .f, ...) {
  map(.x, .f, ...) %>%
    map_if(is.null, ~ NA_character_) %>%
    flatten_chr()
}
