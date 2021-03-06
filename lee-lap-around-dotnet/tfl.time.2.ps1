# Get today's date
$Today = Get-Date

# Get the date for Christmas 2018
$Christmas =  Get-Date -Date '25-12-2018'

# How many days until Christmas 2018?
$TimeToGo = $Christmas - $ToDay
Write-Host "$($TimeToGo.days) days till Christmas 2018"


In this example, `$Today` and `$Christmas` are `System.TimeDate` objects representing today and Christmas 2018 respectively.
The `$TimeToGo` variable, is a `System.TimeSpan` object representing on the time/date difference between today and Christmas.
The TimeSpan object has a number of useful properties, including the number of days in the time span used in this example.

### Adding and subtracting time

A common question I see in the Spiceworks PowerShell forum relates to wanting to see events that happened more than or less than some number of days ago.
For example, any file that has been created in the last 10 days, or any user that has not logged on in the last 30 days.
The `System.DateTime` class has a number of add methods to enable you to add (or subtract) various amounts of time to a date-time object.
For example, to work out when 28 days ago was.



In this example, `$Today` and `$Christmas` are `System.TimeDate` objects representing today and Christmas 2018 respectively.
The `$TimeToGo` variable, is a `System.TimeSpan` object representing on the time/date difference between today and Christmas.
The TimeSpan object has a number of useful properties, including the number of days in the time span used in this example.

### Adding and subtracting time

A common question I see in the Spiceworks PowerShell forum relates to wanting to see events that happened more than or less than some number of days ago.
For example, any file that has been created in the last 10 days, or any user that has not logged on in the last 30 days.
The `System.DateTime` class has a number of add methods to enable you to add (or subtract) various amounts of time to a date-time object.
For example, to work out when 28 days ago was.



In this example, `$Today` and `$Christmas` are `System.TimeDate` objects representing today and Christmas 2018 respectively.
The `$TimeToGo` variable, is a `System.TimeSpan` object representing on the time/date difference between today and Christmas.
The TimeSpan object has a number of useful properties, including the number of days in the time span used in this example.

### Adding and subtracting time

A common question I see in the Spiceworks PowerShell forum relates to wanting to see events that happened more than or less than some number of days ago.
For example, any file that has been created in the last 10 days, or any user that has not logged on in the last 30 days.
The `System.DateTime` class has a number of add methods to enable you to add (or subtract) various amounts of time to a date-time object.
For example, to work out when 28 days ago was.



In this example, `$Today` and `$Christmas` are `System.TimeDate` objects representing today and Christmas 2018 respectively.
The `$TimeToGo` variable, is a `System.TimeSpan` object representing on the time/date difference between today and Christmas.
The TimeSpan object has a number of useful properties, including the number of days in the time span used in this example.

### Adding and subtracting time

A common question I see in the Spiceworks PowerShell forum relates to wanting to see events that happened more than or less than some number of days ago.
For example, any file that has been created in the last 10 days, or any user that has not logged on in the last 30 days.
The `System.DateTime` class has a number of add methods to enable you to add (or subtract) various amounts of time to a date-time object.
For example, to work out when 28 days ago was.

# Get today's date
$Today = Get-Date

# Get the date for Christmas 2018
$Christmas =  Get-Date -Date '25-12-2018'

# How many days until Christmas 2018?
$TimeToGo = $Christmas - $ToDay
Write-Host "$($TimeToGo.days) days till Christmas 2018"
# Get today's date
$Today = Get-Date

# Get the date for Christmas 2018
$Christmas =  Get-Date -Date '25-12-2018'

# How many days until Christmas 2018?
$TimeToGo = $Christmas - $ToDay
Write-Host "$($TimeToGo.days) days till Christmas 2018"
# Get today's date
$Today = Get-Date

# Get the date for Christmas 2018
# Using a UK-based time/date string
$Christmas =  Get-Date -Date '25-12-2018'
# In US Culture
$Christmas =  Get-Date -Date '12-25-2018'
# Handling other cultures is an exercise left for the reader.

# How many days until Christmas 2018?
$TimeToGo = $Christmas - $ToDay
Write-Output -Object "$($TimeToGo.days) days till Christmas 2018"
