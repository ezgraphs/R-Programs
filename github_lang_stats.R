library(ggplot2)
library(sqldf)

# Read the Data
df=read.csv('git_lang_stats.txt',header=TRUE,';')

# Data munging to prep for plotting
df=sqldf("SELECT Language, Repositories, Users from df order by Repositories Desc")
df.top_ten_reps = sqldf("SELECT * from df where rowid <= 10 order by Repositories Desc")
df.top_ten_reps$Language = factor(df.top_ten_reps$Language) # Why do we need to factor - or names "bleed through"
df.top_ten_users = sqldf("SELECT * from df where rowid <= 10 order by Users Desc")
df.top_ten_users$Language = factor(df.top_ten_users$Language) # Why do we need to factor - or names "bleed through"

# Bar Charts
ggplot(data=df.top_ten_reps, aes(Language,Repositories)) + geom_bar() + coord_flip() + opts(title='Top 10 Languages by Github Repositories')
ggsave('top_10_github_languages_by_reps.png')

ggplot(data=df.top_ten_users, aes(Language,Users)) + geom_bar() + coord_flip() + opts(title='Top 10 Languages by Github Users')
ggsave('top_10_github_languages_by_users.png')

# Scatter plots with Line
x=coef(lm(Repositories ~ Users, data=df.top_ten_users))
ggplot(data=df.top_ten_reps, aes(Users,Repositories, color=Language)) + geom_point() + stat_abline(intercept= x[1], slope=x[2], color='brown') +opts(title=paste('Repositories per User:',x[2]))
ggsave('github_languages_reps_per_user_top10.png')

# Scatter plots with Line
x=coef(lm(Repositories ~ Users, data=df))
ggplot(data=df, aes(Users,Repositories)) + geom_point() + stat_abline(intercept= x[1], slope=x[2], color='brown') +opts(title=paste('Repositories per User:',x[2]))
ggsave('github_languages_reps_per_user_all.png')

dev.off()

total.reps=sum(df$Repositories)
df$Rep.pct=round((df$Repositories/total.reps) * 100,2 )

df$Ratio=df$Repositories / df$Users
mean(df[df$Ratio > 0 & df$User > 0 & !is.na(df$Ratio), ])

df
