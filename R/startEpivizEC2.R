# thanks to Dan Tenenbaum @ bioc for this
startEpivizEC2 <- function(...) {
	require(httr, quietly=TRUE)
	public.dns <- httr::content(httr::GET("http://169.254.169.254/latest/meta-data/public-hostname"))

	dots <- list(...)
	dots[["openBrowser"]] <- FALSE
	if (is.null(dots[["port"]])) dots[["port"]] <- 7312L

	mgr <- do.call(startEpiviz,dots)
	url <- gsub("localhost", public.dns, mgr$url)
	tryCatch(mgr$openBrowser(url=url), interrupt=function(int) {})
	mgr
}
