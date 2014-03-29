#TubeStatus
Provides London Tube status updates in your Terminal

#Install
Install via rubygems
```
$ gem install tubestatus
```

# Usage
Display the status for all lines.
```
$ tubestatus
------------------------------------
|      Line       |     Status     |
------------------------------------
| Bakerloo        | Good Service   |
| Central         | Good Service   |
| Circle          | Good Service   |
| District        | Good Service   |
| DLR             | Good Service   |
| H'smith & City  | Good Service   |
| Jubilee         | Good Service   |
| Metropolitan    | Good Service   |
| Northern        | Good Service   |
| Overground      | Part Suspended |
| Piccadilly      | Good Service   |
| Victoria        | Good Service   |
| Waterloo & City | Good Service   |
------------------------------------
```

Display a detailed status for a particular lines
```
$ tubestatus circle
Line: Circle
Status: Good Service
Messages: None

```

