###############################################################################
#### visNetwork
###############################################################################
library(RColorBrewer)

dat <- read.csv('feature-network.csv', stringsAsFactors = FALSE)

#collect nodes
epimark <- unique(c(dat$Feature.from, dat$Feature.to))
N <- length(epimark)
cols <- colorRampPalette(
  brewer.pal(n = 11, name ="Set3"))(N)

names(cols) <- epimark

nodes <- data.frame(
  id=epimark,
  label=epimark,
  color=cols
)


edges <- data.frame(
  from = dat$Feature.from,
  to = dat$Feature.to,
  arrows = "to",
  label = dat$Method
  #, length=length
)

#lnodes <- data.frame(color = cols,
#                     label = names(cols))

vn <- visNetwork(nodes, edges, height = "800px", width = "90%") %>%
  #visPhysics(solver = "barnesHut") %>% 
  # visNodes(font=list(size=30)) %>%  # label size; defalut size 14
  #visLegend(useGroups = F, addNodes = lnodes) %>%
  visEdges(hoverWidth = 0.5, font=list(size=8) )  %>%
  visInteraction(navigationButtons = TRUE) %>% 
  visIgraphLayout(layout="layout_in_circle",smooth = T) %>%
  visOptions(highlightNearest = list(enabled = T, hover = T), 
             nodesIdSelection = T)

visSave(vn, file = 'test.html' )


