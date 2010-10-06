#
# Optimal Weight: Derived from BMI Calculation
#
optimal_weight = function (height, bmi){round((height**2 * bmi) / 703)}

#
# Create an R data frame which is matrix similar to
# http://www.nhlbi.nih.gov/guidelines/obesity/bmi_tbl.htm
#
create_bmi_dataframe =function (bmi_start=19, bmi_end=54,height_inches_start=60, height_inches_end=80)
{
  bmi=c(bmi_start:bmi_end)

  height=(c(height_inches_start:height_inches_end))
  df=data.frame(matrix(NA, ncol=length(bmi), nrow=length(height)))

  for (i in height){
    for (j in bmi){
      df[i-height_inches_start+1,j-bmi_start+1]=optimal_weight(i,j)
    }
  }

  rownames(df)=height
  colnames(df)=bmi
  df
}

# Examples
# create_bmi_dataframe()
print(create_bmi_dataframe(bmi_end=30))

#
# http://www.cdc.gov/healthyweight/assessing/bmi/adult_bmi/index.html
# BMI
# Weight 		Status
# Below 18.5	Underweight
# 18.5 – 24.9	Normal
# 25.0 – 29.9	Overweight
# 30.0 and Above	Obese
#
# http://en.wikipedia.org/wiki/Body_mass_index
# 30 			Obese Class 1 
# 35 			Obese Class 2 
# 40 			Obese Class 3 
#

bmi=c(18.5,25,30,35,40)
height=(c(60:80))
df=data.frame(matrix(NA, ncol=length(bmi), nrow=length(height)))

for (i in height){
  j_index=0
  for (j in bmi){
    j_index = j_index + 1
    df[i-60+1,j_index]=optimal_weight(i,j)
  }
}

rownames(df)=height
colnames(df)=c('Underweight','Normal', 'Overweight','Obese Class 1', 'Obese Class 2')

df$height=rownames(df)
df2=melt(df, id='height')

ggplot(data=df2, aes(x=height, y=value, group=variable, color=variable)) + 
  geom_line() + 
  scale_colour_discrete(name='BMI Upper Limit') + 
  scale_x_discrete('Height in Inches') +
  scale_y_continuous('Weight in Pounds') 

ggsave('BMI.png')