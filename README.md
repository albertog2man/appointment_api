# Appointment API

This is an appointment API created to manage appointments. It implements CRUD, allowing you to create, edit, list and destroy appointments. Ruby backed by the Rails framework are the technologies used. This API follows the principle of least surprise. It allows users to enter the date and time in multiple formats, if essential data is missing it will try to assume what a user ment. This api also checks to make sure time doesnt overlap and that it is in a valid day in the future. When searching for data, it will allow up to 3 different criteria to help narrow search results.

###GET Request

Get request can be done with criteria or without.

####Simple request for all appointments:

'https://guarded-fjord-3968.herokuapp.com/appointment'

or 

'https://https://guarded-fjord-3968.herokuapp.com/

'/appointments' is optional.

####Request for appointments with one criteria:

'https://https://guarded-fjord-3968.herokuapp.com/', '?start_time=05:00pm'

This will give you a filtered list of appointments

####Request with mutliple criteria:

'https://https://guarded-fjord-3968.herokuapp.com/', '?start_time=05:00pm&month=December'

This will give you a filtered list of appointments that match both criteria.
As many as 3 criteria can be used at one time.

table of accepted formats






