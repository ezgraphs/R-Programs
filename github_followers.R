library(rjson)
library(RCurl)
library(igraph)

githubFollowers = function (userToPlot)
{
	user_relations=NULL
	u <- paste('https://api.github.com/users/', userToPlot, '/followers', sep='')
	o <- fromJSON(getURL(u))
	df <- as.data.frame(t(sapply(o, unlist)))
	df$user <- userToPlot
	
	if(nrow(df) > 1){ 
		user_relations <- data.frame(from=df$login, to=df$user)
	}
	print(paste(userToPlot,' ',nrow(user_relations)))
	user_relations
}

githubGraph = function (userToPlot)
{
	relations <- githubFollowers(userToPlot)

	for (i in 1:nrow(relations)) {
		follower <- as.character(relations[i,]$from)
		follower_relations <- githubFollowers(follower)
		
		if(!is.null(follower_relations)){ 
			relations <- merge(relations, follower_relations, all=T)
		}
	}

	relations
}

userToPlot='EzGraphs'
relations = githubGraph(userToPlot)
g <- graph.data.frame(relations, directed = T)
V(g)$label <- V(g)$name
plot(g)
tkplot(g)
rglplot(g)

