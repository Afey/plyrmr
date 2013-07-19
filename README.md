plyrmr
=====

Turn off Hadoop for quick demo

```r
suppressMessages(library(plyrmr))
rmr.options(backend = "local")
```

```
## NULL
```


Create a dataset with to.dfs


```r
mtcars.in = input(mtcars)
```


or simply start from a hdfs path then select some larger engines


```r
mtcars.5cyl.up = subset(mtcars.in, cyl > 4)
```


then group them by cyl


```r
grouped = group.by(mtcars.5cyl.up, "cyl")
```


then look at the average carbs


```r
avg.carbs = summarize(grouped, mean(carb), mean(hp))
```


nothing happened yet, is it real?


```r
as.data.frame(avg.carbs)
```

```
##   cyl.plyrmr.keys   ..1   ..2
## 1               6 3.429 122.3
## 2               8 3.500 209.2
```


This triggers a mapred job and brings the result into mem as a df. Names are still messed up, working on it. If it's too big, you can write it to a specific location.


```r
avg.carbs.out = output(avg.carbs, "/tmp/avg.carbs")
```


You can still read it, if small enough


```r
as.data.frame(avg.carbs.out)
```

```
##   cyl.plyrmr.keys   ..1   ..2
## 1               6 3.429 122.3
## 2               8 3.500 209.2
```


Most functions are modeled after familiar ones

```
  transform #from base
  subset #from base
  filter #synonim for subset
  mutate #from plyr
  summarize #from plyr
  select # synonym for summarize
```

`group.by` takes some dataset and column specs. `group.by.f` takes a function that generates the grouping columns on the fly.
`do` takes a data set and a function and appliess it to chunks of data. It's neither a map or a reduce, this is decided based on 
how it combines with `group.by`. All the functions listed above are implemented with `do` in one line of code. An actual MR job 
is triggered by `from.dfs`, `output` or combining two of `group.by` or `group.by.f` together, since we can't easily optimize
away two groupings into one reduce phase. Comments and suggestions to rhadoop@revolutionanalytics.com.