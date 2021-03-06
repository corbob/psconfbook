
# Define some strings to test
$TDStrings = ('18/08/2018',
              '18/08/2018 16:20:42',
              '8/2018',
              '18/8',
              '07:22:16',
              '7 PM',
              '08/18/2018 16:20:42',
              '2018-08-18T04:20:16.0000000Z',
              '2018-08-18T07:22:16.0000000-07:00',
              'Sat, 18 Aug 2018 07:22:16 GMT',
              '18/08/2018 07:22:16 -5:00'
              )

# What is today?
$Today = Get-Date
Write-Host "Today is $today"

# What culture are we?
$Culture = Get-Culture
Write-Host "Testing in the [$Culture] culture"

# Determine which strings are Date/Time
Foreach  ($TdString in $TimeDateStrings) {
Try {
  $TD = [System.DateTime]::Parse($TdString)
  Write-Host ("String [{0,-35}] is [{1}]" -f $TdString, $TD)
} # end of try
catch {
  Write-Host ("[{0,-35}] invalid valid Time/Date string" -f $TdString)
} # end of catch

} # end of foreach

# Output from this fragment:

#  Today is 05/25/2018 16:03:14
#  Testing in the [en-GB] culture
#  [18/08/2018                         ] is [18/08/2018 00:00:00]
#  [08/18/2018                         ] invalid valid Time/Date string
#  [18/08/2018 16:20:42                ] is [18/08/2018 16:20:42]
#  [8/2018                             ] is [01/08/2018 00:00:00]
#  [18/8                               ] is [18/08/2018 00:00:00]
#  [07:22:16                           ] is [25/05/2018 07:22:16]
#  [7 PM                               ] is [25/05/2018 19:00:00]
#  [08/18/2018 16:20:42                ] invalid valid Time/Date string
#  [2018-08-18T04:20:16.0000000Z       ] is [18/08/2018 05:20:16]
#  [2018-08-18T07:22:16.0000000-07:00  ] is [18/08/2018 15:22:16]
#  [Sat, 18 Aug 2018 07:22:16 GMT      ] is [18/08/2018 08:22:16]
#  [18/08/2018 07:22:16 -5:00          ] is [18/08/2018 13:22:16]

User input probably falls into this class.

In the above examples, date strings in a US format fail. This is because the test is running on a machine using a culture of 'en-GB', or British English.
In the Section on Globalisation, I'll show you some ways to deal with that.

## Building strings with StringBuilder

   As noted earlier, .NET handles memory management for you, which largely eliminates memory leaks that have been a challenge to developers since DOS was first launched.
   .NET's memory management is complex, and does have some potential side-effects

### .NET and Memory

The .NET runtime tracks the usage of memory. If you call a script or a function that allocates memory, for example, assigning a value to a variable, once that script/function has completed, that variable goes out of scope.
.NET then invokes garbage collection to reclaim the memory.
In most cases, this is just low level details.
Most IT Pros can use PowerShell without really caring about how this all works.
Well, in most cases.

For details on memory management and garbage collection in .NET, see: https://docs.microsoft.com/en-us/dotnet/standard/garbage-collection/memory-management-and-gc

A side-effect of how .NET manages memory is how string concatenation is handled.
When you create a string, .NET stores this string in a segment of memory managed by .NET's known as the managed heap.
When you create the string, .NET stores it in a fixed size portion of the heap.
If you concatenate this string with another string, then .NET creates a new, longer string on the heap and the old string is, literally, thrown away.
Eventually, the older string and all the other objects which were thrown away can be garbage collected by .NET's Garbage Collection process.

The impact of this is that if you are concatenating strings a lot, you may be causing extra garbage collection which can hit performance of your scripts.
For most simple cases, IT Pros can just use strings and the sky is not going to fall in.
But if you are building complex reports (ie the concatenation  whole lot of strings!), then you should consider using the `StringBuilder` class and its methods.

### Using StringBuilder

To use the StringBuilder (`System.Text.StringBuilder`), you first instantiate a StringBuilder object.
Then you use the StringBuilder's methods to add to the string.
If needed, you can also remove and replace strings within the StringBuilder object.
Once you have built the string, you render it to an output string using StringBuilder's `ToString()` method.
Like this:


# Define some strings to test
$TDStrings = ('18/08/2018',
              '18/08/2018 16:20:42',
              '8/2018',
              '18/8',
              '07:22:16',
              '7 PM',
              '08/18/2018 16:20:42',
              '2018-08-18T04:20:16.0000000Z',
              '2018-08-18T07:22:16.0000000-07:00',
              'Sat, 18 Aug 2018 07:22:16 GMT',
              '18/08/2018 07:22:16 -5:00'
              )

# What is today?
$Today = Get-Date
Write-Host "Today is $today"

# What culture are we?
$Culture = Get-Culture
Write-Host "Testing in the [$Culture] culture"

# Determine which strings are Date/Time
Foreach  ($TdString in $TimeDateStrings) {
Try {
  $TD = [System.DateTime]::Parse($TdString)
  Write-Host ("String [{0,-35}] is [{1}]" -f $TdString, $TD)
} # end of try
catch {
  Write-Host ("[{0,-35}] invalid valid Time/Date string" -f $TdString)
} # end of catch

} # end of foreach

# Output from this fragment:

#  Today is 05/25/2018 16:03:14
#  Testing in the [en-GB] culture
#  [18/08/2018                         ] is [18/08/2018 00:00:00]
#  [08/18/2018                         ] invalid valid Time/Date string
#  [18/08/2018 16:20:42                ] is [18/08/2018 16:20:42]
#  [8/2018                             ] is [01/08/2018 00:00:00]
#  [18/8                               ] is [18/08/2018 00:00:00]
#  [07:22:16                           ] is [25/05/2018 07:22:16]
#  [7 PM                               ] is [25/05/2018 19:00:00]
#  [08/18/2018 16:20:42                ] invalid valid Time/Date string
#  [2018-08-18T04:20:16.0000000Z       ] is [18/08/2018 05:20:16]
#  [2018-08-18T07:22:16.0000000-07:00  ] is [18/08/2018 15:22:16]
#  [Sat, 18 Aug 2018 07:22:16 GMT      ] is [18/08/2018 08:22:16]
#  [18/08/2018 07:22:16 -5:00          ] is [18/08/2018 13:22:16]

User input probably falls into this class.

In the above examples, date strings in a US format fail. This is because the test is running on a machine using a culture of 'en-GB', or British English.
In the Section on Globalisation, I'll show you some ways to deal with that.

## Building strings with StringBuilder

   As noted earlier, .NET handles memory management for you, which largely eliminates memory leaks that have been a challenge to developers since DOS was first launched.
   .NET's memory management is complex, and does have some potential side-effects

### .NET and Memory

The .NET runtime tracks the usage of memory. If you call a script or a function that allocates memory, for example, assigning a value to a variable, once that script/function has completed, that variable goes out of scope.
.NET then invokes garbage collection to reclaim the memory.
In most cases, this is just low level details.
Most IT Pros can use PowerShell without really caring about how this all works.
Well, in most cases.

For details on memory management and garbage collection in .NET, see: https://docs.microsoft.com/en-us/dotnet/standard/garbage-collection/memory-management-and-gc

A side-effect of how .NET manages memory is how string concatenation is handled.
When you create a string, .NET stores this string in a segment of memory managed by .NET's known as the managed heap.
When you create the string, .NET stores it in a fixed size portion of the heap.
If you concatenate this string with another string, then .NET creates a new, longer string on the heap and the old string is, literally, thrown away.
Eventually, the older string and all the other objects which were thrown away can be garbage collected by .NET's Garbage Collection process.

The impact of this is that if you are concatenating strings a lot, you may be causing extra garbage collection which can hit performance of your scripts.
For most simple cases, IT Pros can just use strings and the sky is not going to fall in.
But if you are building complex reports (ie the concatenation  whole lot of strings!), then you should consider using the `StringBuilder` class and its methods.

### Using StringBuilder

To use the StringBuilder (`System.Text.StringBuilder`), you first instantiate a StringBuilder object.
Then you use the StringBuilder's methods to add to the string.
If needed, you can also remove and replace strings within the StringBuilder object.
Once you have built the string, you render it to an output string using StringBuilder's `ToString()` method.
Like this:


# Define some strings to test
$TDStrings = ('18/08/2018',
              '18/08/2018 16:20:42',
              '8/2018',
              '18/8',
              '07:22:16',
              '7 PM',
              '08/18/2018 16:20:42',
              '2018-08-18T04:20:16.0000000Z',
              '2018-08-18T07:22:16.0000000-07:00',
              'Sat, 18 Aug 2018 07:22:16 GMT',
              '18/08/2018 07:22:16 -5:00'
              )

# What is today?
$Today = Get-Date
Write-Host "Today is $today"

# What culture are we?
$Culture = Get-Culture
Write-Host "Testing in the [$Culture] culture"

# Determine which strings are Date/Time
Foreach  ($TdString in $TimeDateStrings) {
Try {
  $TD = [System.DateTime]::Parse($TdString)
  Write-Host ("String [{0,-35}] is [{1}]" -f $TdString, $TD)
} # end of try
catch {
  Write-Host ("[{0,-35}] invalid valid Time/Date string" -f $TdString)
} # end of catch

} # end of foreach

# Output from this fragment:

#  Today is 05/25/2018 16:03:14
#  Testing in the [en-GB] culture
#  [18/08/2018                         ] is [18/08/2018 00:00:00]
#  [08/18/2018                         ] invalid valid Time/Date string
#  [18/08/2018 16:20:42                ] is [18/08/2018 16:20:42]
#  [8/2018                             ] is [01/08/2018 00:00:00]
#  [18/8                               ] is [18/08/2018 00:00:00]
#  [07:22:16                           ] is [25/05/2018 07:22:16]
#  [7 PM                               ] is [25/05/2018 19:00:00]
#  [08/18/2018 16:20:42                ] invalid valid Time/Date string
#  [2018-08-18T04:20:16.0000000Z       ] is [18/08/2018 05:20:16]
#  [2018-08-18T07:22:16.0000000-07:00  ] is [18/08/2018 15:22:16]
#  [Sat, 18 Aug 2018 07:22:16 GMT      ] is [18/08/2018 08:22:16]
#  [18/08/2018 07:22:16 -5:00          ] is [18/08/2018 13:22:16]

User input probably falls into this class.

In the above examples, date strings in a US format fail. This is because the test is running on a machine using a culture of 'en-GB', or British English.
In the Section on Globalisation, I'll show you some ways to deal with that.

## Building strings with StringBuilder

   As noted earlier, .NET handles memory management for you, which largely eliminates memory leaks that have been a challenge to developers since DOS was first launched.
   .NET's memory management is complex, and does have some potential side-effects

### .NET and Memory

The .NET runtime tracks the usage of memory. If you call a script or a function that allocates memory, for example, assigning a value to a variable, once that script/function has completed, that variable goes out of scope.
.NET then invokes garbage collection to reclaim the memory.
In most cases, this is just low level details.
Most IT Pros can use PowerShell without really caring about how this all works.
Well, in most cases.

For details on memory management and garbage collection in .NET, see: https://docs.microsoft.com/en-us/dotnet/standard/garbage-collection/memory-management-and-gc

A side-effect of how .NET manages memory is how string concatenation is handled.
When you create a string, .NET stores this string in a segment of memory managed by .NET's known as the managed heap.
When you create the string, .NET stores it in a fixed size portion of the heap.
If you concatenate this string with another string, then .NET creates a new, longer string on the heap and the old string is, literally, thrown away.
Eventually, the older string and all the other objects which were thrown away can be garbage collected by .NET's Garbage Collection process.

The impact of this is that if you are concatenating strings a lot, you may be causing extra garbage collection which can hit performance of your scripts.
For most simple cases, IT Pros can just use strings and the sky is not going to fall in.
But if you are building complex reports (ie the concatenation  whole lot of strings!), then you should consider using the `StringBuilder` class and its methods.

### Using StringBuilder

To use the StringBuilder (`System.Text.StringBuilder`), you first instantiate a StringBuilder object.
Then you use the StringBuilder's methods to add to the string.
If needed, you can also remove and replace strings within the StringBuilder object.
Once you have built the string, you render it to an output string using StringBuilder's `ToString()` method.
Like this:


# Define some strings to test
$TDStrings = ('18/08/2018',
              '18/08/2018 16:20:42',
              '8/2018',
              '18/8',
              '07:22:16',
              '7 PM',
              '08/18/2018 16:20:42',
              '2018-08-18T04:20:16.0000000Z',
              '2018-08-18T07:22:16.0000000-07:00',
              'Sat, 18 Aug 2018 07:22:16 GMT',
              '18/08/2018 07:22:16 -5:00'
              )

# What is today?
$Today = Get-Date
Write-Host "Today is $today"

# What culture are we?
$Culture = Get-Culture
Write-Host "Testing in the [$Culture] culture"

# Determine which strings are Date/Time
Foreach  ($TdString in $TimeDateStrings) {
Try {
  $TD = [System.DateTime]::Parse($TdString)
  Write-Host ("String [{0,-35}] is [{1}]" -f $TdString, $TD)
} # end of try
catch {
  Write-Host ("[{0,-35}] invalid valid Time/Date string" -f $TdString)
} # end of catch

} # end of foreach

# Output from this fragment

#  Today is 05/25/2018 16:03:14
#  Testing in the [en-GB] culture
#  [18/08/2018                         ] is [18/08/2018 00:00:00]
#  [08/18/2018                         ] invalid valid Time/Date string
#  [18/08/2018 16:20:42                ] is [18/08/2018 16:20:42]
#  [8/2018                             ] is [01/08/2018 00:00:00]
#  [18/8                               ] is [18/08/2018 00:00:00]
#  [07:22:16                           ] is [25/05/2018 07:22:16]
#  [7 PM                               ] is [25/05/2018 19:00:00]
#  [08/18/2018 16:20:42                ] invalid valid Time/Date string
#  [2018-08-18T04:20:16.0000000Z       ] is [18/08/2018 05:20:16]
#  [2018-08-18T07:22:16.0000000-07:00  ] is [18/08/2018 15:22:16]
#  [Sat, 18 Aug 2018 07:22:16 GMT      ] is [18/08/2018 08:22:16]
#  [18/08/2018 07:22:16 -5:00          ] is [18/08/2018 13:22:16]

User input probably falls into this class.

In the above examples, date strings in a US format fail. This is because the test is running on a machine using a culture of 'en-GB', or British English.
In the Section on Globalisation, I'll show you some ways to deal with that.


## Building strings with StringBuilder

   As noted earlier, .NET handles memory management for you, which largely eliminates memory leaks that have been a challenge to developers since DOS was first launched.
   .NET's memory management is complex, and does have some potential side-effects

### .NET and Memory

The .NET runtime tracks the usage of memory. If you call a script or a function that allocates memory, for example, assigning a value to a variable, once that script/function has completed, that variable goes out of scope.
.NET then invokes garbage collection to reclaim the memory.
In most cases, this is just low level details.
Most IT Pros can use PowerShell without really caring about how this all works.
Well, in most cases.

For details on memory management and garbage collection in .NET, see: https://docs.microsoft.com/en-us/dotnet/standard/garbage-collection/memory-management-and-gc

A side-effect of how .NET manages memory is how string concatenation is handled.
When you create a string, .NET stores this string in a segment of memory managed by .NET's known as the managed heap.
When you create the string, .NET stores it in a fixed size portion of the heap.
If you concatenate this string with another string, then .NET creates a new, longer string on the heap and the old string is, literally, thrown away.
Eventually, the older string and all the other objects which were thrown away can be garbage collected by .NET's Garbage Collection process.

The impact of this is that if you are concatenating strings a lot, you may be causing extra garbage collection which can hit performance of your scripts.
For most simple cases, IT Pros can just use strings and the sky is not going to fall in.
But if you are building complex reports (ie the concatenation  whole lot of strings!), then you should consider using the `StringBuilder` class and its methods.

### Using StringBuilder

To use the StringBuilder (`System.Text.StringBuilder`), you first instantiate a StringBuilder object.
Then you use the StringBuilder's methods to add to the string.
If needed, you can also remove and replace strings within the StringBuilder object.
Once you have built the string, you render it to an output string using StringBuilder's `ToString()` method.
Like this:


# Define some strings to test
$TDStrings = ('18/08/2018',
              '18/08/2018 16:20:42',
              '8/2018',
              '18/8',
              '07:22:16',
              '7 PM',
              '08/18/2018 16:20:42',
              '2018-08-18T04:20:16.0000000Z',
              '2018-08-18T07:22:16.0000000-07:00',
              'Sat, 18 Aug 2018 07:22:16 GMT',
              '18/08/2018 07:22:16 -5:00'
              )

# What is today?
$Today = Get-Date
Write-Host "Today is $today"

# What culture are we?
$Culture = Get-Culture
Write-Host "Testing in the [$Culture] culture"

# Determine which strings are Date/Time
Foreach  ($TdString in $TimeDateStrings) {
Try {
  $TD = [System.DateTime]::Parse($TdString)
  Write-Host ("String [{0,-35}] is [{1}]" -f $TdString, $TD)
} # end of try
catch {
  Write-Host ("[{0,-35}] invalid valid Time/Date string" -f $TdString)
} # end of catch

} # end of foreach

# Output from this fragment

#  Today is 05/25/2018 16:03:14
#  Testing in the [en-GB] culture
#  [18/08/2018                         ] is [18/08/2018 00:00:00]
#  [08/18/2018                         ] invalid valid Time/Date string
#  [18/08/2018 16:20:42                ] is [18/08/2018 16:20:42]
#  [8/2018                             ] is [01/08/2018 00:00:00]
#  [18/8                               ] is [18/08/2018 00:00:00]
#  [07:22:16                           ] is [25/05/2018 07:22:16]
#  [7 PM                               ] is [25/05/2018 19:00:00]
#  [08/18/2018 16:20:42                ] invalid valid Time/Date string
#  [2018-08-18T04:20:16.0000000Z       ] is [18/08/2018 05:20:16]
#  [2018-08-18T07:22:16.0000000-07:00  ] is [18/08/2018 15:22:16]
#  [Sat, 18 Aug 2018 07:22:16 GMT      ] is [18/08/2018 08:22:16]
#  [18/08/2018 07:22:16 -5:00          ] is [18/08/2018 13:22:16]


# Define some strings to test
$TDStrings = ('18/08/2018',
              '18/08/2018 16:20:42',
              '8/2018',
              '18/8',
              '07:22:16',
              '7 PM',
              '08/18/2018 16:20:42',
              '2018-08-18T04:20:16.0000000Z',
              '2018-08-18T07:22:16.0000000-07:00',
              'Sat, 18 Aug 2018 07:22:16 GMT',
              '18/08/2018 07:22:16 -5:00'
              )

# What is today?
$Today = Get-Date
Write-Host "Today is $today"

# What culture are we?
$Culture = Get-Culture
Write-Host "Testing in the [$Culture] culture"

# Determine which strings are Date/Time
Foreach  ($TdString in $TimeDateStrings) {
Try {
  $TD = [System.DateTime]::Parse($TdString)
  Write-Host ("String [{0,-35}] is [{1}]" -f $TdString, $TD)
} # end of try
catch {
  Write-Host ("[{0,-35}] invalid valid Time/Date string" -f $TdString)
} # end of catch

} # end of foreach

# Output from this fragment

#  Today is 05/25/2018 16:03:14
#  Testing in the [en-GB] culture
#  [18/08/2018                         ] is [18/08/2018 00:00:00]
#  [08/18/2018                         ] invalid valid Time/Date string
#  [18/08/2018 16:20:42                ] is [18/08/2018 16:20:42]
#  [8/2018                             ] is [01/08/2018 00:00:00]
#  [18/8                               ] is [18/08/2018 00:00:00]
#  [07:22:16                           ] is [25/05/2018 07:22:16]
#  [7 PM                               ] is [25/05/2018 19:00:00]
#  [08/18/2018 16:20:42                ] invalid valid Time/Date string
#  [2018-08-18T04:20:16.0000000Z       ] is [18/08/2018 05:20:16]
#  [2018-08-18T07:22:16.0000000-07:00  ] is [18/08/2018 15:22:16]
#  [Sat, 18 Aug 2018 07:22:16 GMT      ] is [18/08/2018 08:22:16]
#  [18/08/2018 07:22:16 -5:00          ] is [18/08/2018 13:22:16]


# Define some strings to test
$TdStrings = ('18/08/2018',
              '18/08/2018 16:20:42',
              '8/2018',
              '18/8',
              '07:22:16',
              '7 PM',
              '08/18/2018 16:20:42',
              '2018-08-18T04:20:16.0000000Z',
              '2018-08-18T07:22:16.0000000-07:00',
              'Sat, 18 Aug 2018 07:22:16 GMT',
              '18/08/2018 07:22:16 -5:00'
              )

# What is today?
$Today = Get-Date
Write-Output "Today is $today"

# What culture are we?
$Culture = Get-Culture
Write-Output "Testing in the [$Culture] culture"

# Determine which strings are Date/Time
Foreach  ($TdString in $TdStrings) {
Try {
  $TD = [System.DateTime]::Parse($TdString)
  Write-Output ("String [{0,-35}] is [{1}]" -f $TdString, $TD)
} # end of try
catch {
  Write-Output ("[{0,-35}] is an invalid Time/Date string" -f $TdString)
} # end of catch

} # end of foreach

# Output from this fragment

#  Today is 05/25/2018 16:03:14
#  Testing in the [en-GB] culture
#  [18/08/2018                         ] is [18/08/2018 00:00:00]
#  [08/18/2018                         ] is an invalid Time/Date string
#  [18/08/2018 16:20:42                ] is [18/08/2018 16:20:42]
#  [8/2018                             ] is [01/08/2018 00:00:00]
#  [18/8                               ] is [18/08/2018 00:00:00]
#  [07:22:16                           ] is [25/05/2018 07:22:16]
#  [7 PM                               ] is [25/05/2018 19:00:00]
#  [08/18/2018 16:20:42                ] is an invalid Time/Date string
#  [2018-08-18T04:20:16.0000000Z       ] is [18/08/2018 05:20:16]
#  [2018-08-18T07:22:16.0000000-07:00  ] is [18/08/2018 15:22:16]
#  [Sat, 18 Aug 2018 07:22:16 GMT      ] is [18/08/2018 08:22:16]
#  [18/08/2018 07:22:16 -5:00          ] is [18/08/2018 13:22:16]

