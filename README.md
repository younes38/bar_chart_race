# bar_chart_race

 A library to draw fantastic bar charts race in Flutter  
<img src="https://github.com/younes38/bar_chart_race/blob/main/bar_chart_race.gif" width="220" height="400" />

## Usage 

### Let's get started  
add the dependencies to your app:

```yaml
dependencies:
  bar_chart_race: ^0.0.1
```
then import it:  
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

## Contribution
pull requests are welcome!

## Last but not least
the package is still in its first version so it may contains some issues.
