# html - exercise

# 1. Go to the website of the Parliament of Australia

# 2. Go to the list of all current members

# 3. Set the results per page to the maximum

# 4. Look at the source code

# 5. Find a css path for the names (and links) to all members on the first page (use the Selector Gadget, if necessary)

# 6. Load the page into R

# 7. Use the rvest package and the css path from above to extract all elements, and store them in an object.
nodes_01 <- read_html("https://www.aph.gov.au/Senators_and_Members/Parliamentarian_Search_Results?&q=&mem=1&par=-1&gen=0&ps=96&st=1") %>% 
  html_nodes(".title a")

# 8. Get the href attribute for all elements

html_attr(nodes_01, name = "href")

# 9. Get the text for all elements

html_text2(nodes_01)

# 10. Create a data.frame with two columns, the link/href from above and the the name/text from above. Store the data.frame in an object.

df01 <- data.frame(name = html_text(nodes_01),
                   str_c("https://www.aph.gov.au", html_attr(nodes_01, name = "href")))

# 11. Try finding a CSS path for the party of the members on the page. (It might not be possible.)
parties <- read_html("https://www.aph.gov.au/Senators_and_Members/Parliamentarian_Search_Results?&q=&mem=1&par=-1&gen=0&ps=96&st=1") |> 
  html_nodes(xpath = "//dt[contains(text(),'Party')]/following-sibling::dd[1]") |> 
  html_text(trim = TRUE)

# 12. How would you add the party of members to your dataset?
df01 <- data.frame(name = html_text(nodes_01),
                   url = str_c("https://www.aph.gov.au", html_attr(nodes_01, name = "href")),
                   party = parties)
