## Iterative functions ##

## Shortcut Reminder:
# ctrl + enter (or cmnd + enter) to run the line of code your cursor is currently on
# 'tab' to autocomplete, arrow up and down through the options

## for loops
  # create a vector of values 1 to 10
vec <- c(1:10)

  # create for loop to print out each value
for (i in vec){
  print(i)
}

  # create a for loop to only print out values divisible by 2
for (i in vec){
  if (i%%2==0){print(i)}
}

  # create another vector of values ranging 1 to 5
vec2<- c(1:5)

  # create a for loop that multiplies values from the two vectors and prints those divisible by 3

for (i in vec){
  for (j in vec2){
    val <- i*j
    if (val%%3==0){
      print(val)
    }
  }
}

## apply functions

df <- data.frame(x = 1:4, y = 25:38, z=89:92)


  # create a vector of the mean of each row of df
mean <- apply(df, MARGIN = 1, mean)

  # apply the function sqrt() to all values in the vector
sqrt_mean <- sapply(mean, sqrt)

  # create code that will print "The square root of [value] is [square root of value]." 
  # using the values obtained using the apply functions

for (i in 1:length(mean)){
  print(paste0("The square root of ", mean[i], " is ", sqrt_mean[i], "."))
}


