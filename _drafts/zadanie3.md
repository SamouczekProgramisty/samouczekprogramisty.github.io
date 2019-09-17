Krzysiek po bootcamp'ie, zadanie od małej firmy

Movie DB
Design and implement JSON​API service to store and manage simple movie database.
Functional requirements
­ users should be able to register themselves using login​and password​and receive
access token​to the movie database
­ users should be able to remove their account
­ users should be able to add new entries about movies: title​, description​and
watched​flag
­ users should be able to list all entries
­ users should be able to filter movies by watched​flag (all, watched, unwatched)
­ users should be able to edit movies
­ users should be able to delete movies

Non­functional requirements
­ all movie database endpoints should be protected by the access token
­ static health­check endpoint responding with JSON { “status”: “ok” }
­ Java 8
­ relational database of your choice
­ store record IDs as UUIDs
­ git / mercurial repository (Bitbucket / Github)
­ documentation (README) should be provided on how to:
­ install the application
­ run the application locally
­ run automatic tests
­ use API endpoint(s) (no need to be 100% complete)

Evaluation criteria
­ code quality and readability
­ presence and quality of (or lack of) automatic tests
­ commits history (thought process, commit messages)
Bonus points
­ deploy the application on a free cloud service (i.e. Heroku)
