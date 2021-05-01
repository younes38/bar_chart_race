# bar_chart_race

 A library to draw fantastic bar charts race in Flutter


## Usage 

### Let's get started  
add the dependencies to your app and import it  

```yaml
dependencies:
  bar_chart_race:
```
```import 'package:bar_chart_race/bar_chart_race.dart';```

then you can simply use: 

```Dart
BarChartRace(
            data: data,
            initialPlayState: true,
          )
```
this will create a bar chart with random colors and animate it.  
the  ``` data ``` and ``` initialPlayState ``` are required and here the exmplanation for most of the properties  
* ``` data ```: the data you are going to show and it should contains at lease two rows and two columns
* ``` initialPlayState ```: if it's ```true``` then the bar chart will be animated
* ``` framesPerSecond ```: defines the number of frames to show per seconds
* ``` columnsLabel ```: represents the name of the columns
* ``` statesLabel ```: represents the name of the rows (usually time)
* ``` numberOfRactanglesToShow ```: represents the number of the first columns to show
* ``` title ```: The title of the bar chart race
* ``` columnsColor ```: the color of each rectangle

## And the last but not least
pull requests are welcome!
the package is still in its first version so it may contains some issues.

