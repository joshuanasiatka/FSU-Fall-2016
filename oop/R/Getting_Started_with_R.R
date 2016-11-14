# Assignment Operators
x = 8
x*3
x <- 8
x*3
assign("x",3)
x*3
class(x)
is.numeric(x)


# Strings
name <- "Natasha X"
nchar(name)
name <- "Natasha"
nchar(name)
nchar("name")


# Dates
x <- as.Date("2016-10-31")
y <- 2016-10-31
class(x)
class(y)


# Data Comparison
x <- 2
y <- 3
x == y
x != y
n <- "boat"
m <- "hat"
n < m


# Vectors
v1 <- c(5,1,3)
v2 <- c("ann","paul","mary")
v1
v2
v1*2
v1^2
sqrt(v1)
a <- 2:8
a
b <- 3:9
b
a+b
length(a)


# Defining Lists
a <- 1:10
a < 5
any(a < 5)
all(a < 5)
b <- 20:30
b
b[2]
b[3:5]


# Data Frames
id <- 1:5
fname <- c("Ann","Bob","Paul","Mary","Kevin")
age <- c(20,40,35,28,52)
a <- data.frame(id,fname,age)
a

## Specific Entries in Data Frames
a[2,3]  # print row 2 col 3
a[2,]   # print row 2
a[,3]   # print col 3
a[,2:3] # print cols 2 and 3


# Lists: Specific Names to List Elements
a <- list(1, "Ann", 29)
a
names(a) <- c("id","fname","age")
a[["age"]]
a

## Adding New Entries to that List
a[["lname"]] <- "Johnson"
a
length(a)


# Matrices
x <- matrix(1:12, nrow=3)
x
y <- matrix(11:22, nrow=3)
y
x*y