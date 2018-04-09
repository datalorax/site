library(fs)
library(glue)
library(purrr)

system('cd render && ren "*.md" "#1.txt"')

txt_files <- dir_ls("render", glob = "*.txt")

replace <- function(file) {
  file <- as.character(file)
  lines <- readLines(file)
  fence <- grep("```", lines)
  lines[fence] <- ifelse(grepl("##", lines[fence + 1]), "```r", lines[fence]) 
  writeLines(lines, file)  
}

walk(txt_files, replace)
walk(glue("sed -i -e 's_!\\[\\](_!\\[\\](\\.\\./_g' {file}", file = txt_files), system)

system('cd render && ren "*.txt" "#1.md"')

md_files <- dir_ls("./render", glob = "*.md")
names <- gsub("\\./.+/(.+)\\..+", "\\1", md_files)
walk2(md_files, names, ~file_move(.x, glue("content/post/{.y}.md")))

folder_dir <- dir_ls("render", type = "directory")
folder_nms <- gsub(".+\\/", "", folder_dir)
walk2(folder_dir, folder_nms, ~file_move(.x, glue("static/post/{.y}")))

file_delete(dir_ls("render", glob = "*.txt-e"))
