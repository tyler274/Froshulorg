google.load("visualization", "1", {packages:["corechart"]});

$(function()
{
    function zero(){return 0;}
    var histograms = $('.histogram');
    var histogramData = [];
    var largest = 0;
    for(var i = 0; i < histograms.length; i++)
    {
        var votes = JSON.parse(histograms[i].getAttribute('data-votes'));
        console.log(votes);
        var histogram = [0, 0, 0, 0, 0];
        for(var j = 0; j < votes.length; j++)
        {
            console.log(votes[j]);
            if(votes[j] >= 1 && votes[j] <= 5)
            {
                histogram[votes[j] - 1]++;
            }
        }
        histogramData.push(histogram);
        for(j = 0; j < histogram.length; j++)
        {
            if(histogram[j] > largest)
            {
                largest = histogram[j];
            }
        }
    }
    function wrap(value, index){return [index + 1, value];}
    for(i = 0; i < histograms.length; i++)
    {
        console.log(histogramData[i]);
        ary = histogramData[i].map(wrap);
        ary.unshift(['vote', 'count']);
        var data = google.visualization.arrayToDataTable(ary);
//        var data = google.visualization.arrayToDataTable([['thing', 'thang'], [1, 2], [3, 4]]);
        var chart = new google.visualization.BarChart(histograms[i]);
        var options = 
        {
            legend: {position: 'none'},
            hAxis: {viewWindow: {max: largest}},
            chartArea: {left: '10%', top:0, width:'85%', height:'90%'}
        };
        chart.draw(data, options);
    }

});
