# Appointment API

This is an appointment API created to manage appointments. It implements CRUD, allowing you to create, edit, list and destroy appointments. Ruby backed by the Rails framework are the technologies used. This API follows the principle of least surprise. It allows users to enter the date and time in multiple formats, if essential data is missing it will try to assume what a user meant. This api also checks to make sure time doesn't overlap and that it is in a valid day in the future. When searching for data, it will allow up to 3 different criteria to help narrow search results.

###Formats

Several different time and date syntaxes are supported. If the time syntax used doesn't not specify am or pm it will assume business hours.

#### Time Formats
|                             |         |                                         |
|-----------------------------|---------|-----------------------------------------|
| single digit                |    5    | Assumes business hours                  |
| single digit with am/pm     |   5pm   | Assumes at the start of the hour        |
| hour and minutes no am/pm   |   5:00  | Assumes business hours                  |
| hour and minutes no am/pm   |  05:00  | Assumes business hours                  |
| hour and minutes with am/pm |  5:00pm | Uses exact time                         |
| hour and minutes with am/pm | 05:00pm | all other formats get converted to this |
|                             |         |                                         |

#### Date Formats

|                           |          |                                         |
|---------------------------|----------|-----------------------------------------|
| The numeric value         |    12    | Month numbers 1 - 12                    |
| Three letter abbreviation |    Dec   | Must be first 3 letters caps insensitve |
| Full month name           | December | Full name caps insensitve               |
|                           |          |                                         |

###GET Request

Get request can be done with criteria or without.

####Simple request for all appointments:

GET `https://guarded-fjord-3968.herokuapp.com/appointment`

or 

GET `https://https://guarded-fjord-3968.herokuapp.com/`

`/appointments` is optional.

####Request for appointments with one criteria:

GET `https://https://guarded-fjord-3968.herokuapp.com/`, `?start_time=05:00pm`

This will give you a filtered list of appointments.

####Request with mutliple criteria:

GET `https://https://guarded-fjord-3968.herokuapp.com/`, `?start_time=05:00pm&month=December`

This will give you a filtered list of appointments that match both criteria.
As many as 3 criteria can be used at one time.

###POST Request

Post request must be in any of the valid formats as well as a valid date in the future. The fields ```start_time, end_time, day, month, year, first_name, last_name``` are required. Comments is an optional field.

####Sample request
	
```
POST https://https://guarded-fjord-3968.herokuapp.com/appointments
    -H "Content-type" => "application/json"
    -H "Accept" => "application/json"
    -d '{ "appointment":{"first_name": "Bill", "last_name": "Gonzo", "start_time":"5:00", "end_time": "6:00","day": "13","month": "12", "year": "2015"}}'
```
     
###PATCH Request
 \#\#\#WARNING\#\#\#  
\#This is distructive\#
  
  Patch requests are validated just like post requests. They do not create a new entity they alter an existing. A appointment ID number is required to do a patch request.

```
PATCH https://https://guarded-fjord-3968.herokuapp.com/appointments/1
	 -H "Content-type" => "application/json"
     -H "Accept" => "application/json"
     -d '{ "appointment": {"start_time": "5:00'"}}'
```

###DELETE Request
 \#\#\#WARNING\#\#\#  
\#This is distructive\#

  Delete requires a appointment ID.

```
DELETE "https://https://guarded-fjord-3968.herokuapp.com/appointments/1"
```
