library(ggplot)

max_iter=25
cl=colours()
step=seq(-2,0.8,by=0.005)
points=array(0,dim=c(length(step)^2,3))
t=0

for(a in step)
{
  for(b in step+0.6)
  {
    x=0;y=0;n=0;dist=0
    while(n<max_iter & dist<4)
    {
      n=n+1
      newx=a+x^2-y^2
      newy=b+2*x*y
      dist=newx^2+newy^2
      x=newx;y=newy
    }

    if(dist<4)
    { 
      color=24 # black
    }
    else
    {
      color=n*floor(length(cl)/max_iter)
    }

    t=t+1
    points[t,]=c(a,b,color)
  }
}

df=as.data.frame(points)	

ggplot(data=df, aes(V1, V2, color=cl[V3]))+ 
   geom_point() + 
   opts(panel.background=theme_blank(), 
      panel.grid.major=theme_blank(), 
      panel.grid.minor=theme_blank(), 
      axis.ticks=theme_blank(), 
      axis.text.x=theme_blank(), 
      axis.text.y=theme_blank(), 
      axis.title.x=theme_blank(), 
      axis.title.y=theme_blank(),
      legend.position = 'none' )  

# Can change the colors by fiddling with the following.
# last_plot() + scale_colour_manual(values=sort(c("#00000000", rainbow(23)), decreasing=FALSE))