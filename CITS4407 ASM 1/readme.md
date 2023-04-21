# CITS4407 Project 1

## Dataset

### Sample Dataset

`Cyber_Security_Breaches.tsv`

### Dataset Structure

| **Name_of_Covered_Entity**         | **State** | **Individuals_Affected** | **Date_of_Breach** | **Type_of_Breach**             | **Location_of_Breached_Information** | **Summary** | **year** | **index**   |
| ---------------------------------- | --------- | ------------------------ | ------------------ | ------------------------------ | ------------------------------------ | ----------- | -------- | ----------- |
| **UNCG Speech and Hearing Center** | NC        | 2300                     | 1/1/97             | Hacking/IT Incident            | Desktop Computer                     |             | 1997     | 32343736038 |
| **UMass Memorial Medical Center**  | MA        | 2387                     | 5/6/02             | Unauthorized Access/Disclosure | Electronic Medical Record, Paper     |             | 2002     | 36925152965 |

## Command Usage

1. `maxstate` -> report the code for the state that has the largest number of incidents across all years, and the corresponding count. If there are more than one such state, just report one of them.
2. `maxyear` -> report the year with the greatest number of incidences across all the states, and the corresponding count. If there are more than one such year, just report one of them.
3. `<A two letter state code>` -> For the named state, report the year with the maximum number of incidents, and the count (If more than one, any one of them).
4. `<A four digit year> ` -> For the named year, report the state with the maximum number of incidents for that year, and the count (If more than one, any one of them).

### Valid Input Examples:

`$ cyber_breaches Cyber_Security_Breaches.tsv maxstate`

-> `State with greatest number of incidents is: CA with count 113`

`$ cyber_breaches Cyber_Security_Breaches.tsv maxyear`

-> `Year with greatest number of incidents is: 2013 with count 254`

`$ cyber_breaches Cyber_Security_Breaches.tsv 2010`

-> `State with greatest number of incidents for 2010 is in TX with count 18`

`$ cyber_breaches Cyber_Security_Breaches.tsv TX`

-> `Year with greatest number of incidents for TX is in 2010 with count 18`

### Invalid Input Examples:

`$ cyber_breaches Cyber_Security_Breaches.tsv maxnear`

-> `The max commands are either maxstate or maxyear`

## Testing

A test script can be found at `./tests.sh`

Simply run `./tests.sh` , and a test result will be printed like:

```
Testcase  0: <maxstate> ... PASSED!
Testcase  1: <maxyear>  ... PASSED!
Testcase  2: <2010>     ... PASSED!
Testcase  3: <2013>     ... PASSED!
Testcase  4: <2011>     ... PASSED!
Testcase  5: <2009>     ... PASSED!
Testcase  6: <9999>     ... PASSED!
Testcase  7: <TX>       ... PASSED!
Testcase  8: <CA>       ... PASSED!
Testcase  9: <maxnear>  ... PASSED!
Testcase 10: <ca>       ... PASSED!
Testcase 11: <xx>       ... PASSED!
Testcase 12: <AA>       ... PASSED!
Testcase 13: <201>      ... FAILED!
Testcase 14: <20100>    ... PASSED!
Testcase 15: <20101>    ... PASSED!
----------------------------------------------------------------------------------------------------
16 testcases ran, 15 PASSED, 1 FAILED.
Failed Testcases: 
Testcase 13: <201>
```

