<# Creating World Map Graphs
All Versions
If you have data related to countries, you may want to visualize and highlight this geographic data. Classic bar- and chart-graphs won't always work here. 
Fortunately, there are free online geographic charts available that PowerShell can use. Here is a function you can try: #>
function Show-MapGraph
{
    param
    (
        [Parameter(Mandatory,ValueFromPipeline)]
        $InputObject,
 
        [Parameter(Mandatory)]
        [string]
        $Property,
 
        [string]
        $Label = 'Items'
    )
 
    begin
    {
        
        $bucket = [System.Collections.ArrayList]::new()
    }
    process
    {
        $null = $bucket.Add($_) 
    }
    end
    {
        $groups = $bucket | Where-Object { $_.$Property } | Group-Object -Property $Property -NoElement 
        $data = foreach ($group in $groups)
        {
            "['{0}',{1}]" -f $group.Name, $group.Count
        }
 
        $datastring = $data -join "`r`n,"
 
        $HTMLPage = @"
<html>
  <head>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {
        'packages':['geochart'],
      });
      google.charts.setOnLoadCallback(drawRegionsMap);
 
      function drawRegionsMap() {
        var data = google.visualization.arrayToDataTable([
          ['Country', '$Label'],
          $datastring
        ]);
 
        var options = {
          
          colorAxis: {colors: ['#00FF00', '#004400']},
          backgroundColor: '#81d4fa',
          datalessRegionColor: '#AAAABB',
          defaultColor: '#f5f5f5',
        };
 
        var chart = new google.visualization.GeoChart(document.getElementById('regions_div'));
 
        chart.draw(data, options);
      }
    </script>
  </head>
  <body>
    <div id="regions_div" style="width: 900px; height: 500px;"></div>
  </body>
</html>
"@
    
        $timestamp = Get-Date -Format 'HHmmss'
        $OutPath = "$env:temp\Graph$timestamp .html"
        $HTMLPage | Out-File -FilePath $OutPath -Encoding utf8
        Start-Process $outpath
    }
}  

<# Show-MapGraph basically creates a HTML web page for you, fills it with the appropriate script calls, and then displays it. 
All you need to do is pipe in your country data, and use -Property to indicate which object property contains the country name. #>
