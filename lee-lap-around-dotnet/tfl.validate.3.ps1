$String1 = '    1234    ' # Both

# Trim leading spaces
Write-Output 'Trimming Start'
Write-Output ("[$string1] -> [$($String1.TrimStart())]")

Write-Output 'Trimming End'
Write-Output ("[$string1] -> [$($String1.TrimEnd())]")

Write-Output 'Trimming both'
Write-Output ("[$string1] -> [$($String1.Trim())]")

#  Output from this fragment
#
#  Trimming Start
#  [    1234    ] -> [1234    ]
#  Trimming End
#  [    1234    ] -> [    1234]
#  Trimming both
#  [    1234    ] -> [1234]

