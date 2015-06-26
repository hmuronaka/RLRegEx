# RLRegEx

RegularExpression in Swift.

# INSTALL

Please copy files in Class folder to your project.

# Examples

## match

```swift

let m1 = "http".match("http")
m1.count == 1
m1[0] == "http"

let m2 = "http://abc/de/".match("http://(.*)")
m2.count == 2
m2[0] == "http://abc/de/"
m2[1] == "abc/de/"

let m3 = "http://abc/de/".match("(\\w+)")
m3.count == 2
m3[0] == "http"
m3[1] == "http"

let m4 = "http".match("")
m4 == nil

```

## matches

```swift

"http".matches("http") { (m) -> Bool in 
    m.count == 1
    m[0] == "http"
    return true
}

"http://abc/de/".matches("http://(.*)") { (m) -> Bool in
    m.count == 2
    m[0] == "http://abc/de/"
    m[1] == "abc/de/"
    return true
}

var total = 0
"http://abc/de/".matches("(\\w+)") { (m) -> Bool in
    switch(total) {
    case 0:
        m.count == 2
        m[0] == "http"
        m[1] == "http"
        break;
    case 1:
        m.count == 2
        m[0] == "abc"
        m[1] == "abc"
        break;
    case 2:
        m.count == 2
        m[0] == "de"
        m[1] == "de"
        break;
    }
    total++
    return true
}
```

## gsub

```swift
"http://ac/bd/".gsub("/\\w+", replacement: "/AC")! == "http://AC/AC/"

"http://ac/bd/".gsub("http://(\\w+)/(\\w+)", replacement: "$0")! == "http://ac/bd/"
"http://ac/bd/".gsub("http://(\\w+)/(\\w+)", replacement: "$1")! == "ac/"
"http://ac/bd/".gsub("http://(\\w+)/(\\w+)/", replacement: "$1")! == "ac"
"http://ac/bd/".gsub("(\\w+)/(\\w+)", replacement: "$2")! == "http://bd/"

"http://ac/bd/".gsub("(\\w+)/(\\w+)", replacement: "$1$2")! == "http://acbd/"
"http://ac/bd/".gsub("http://(\\w+)/(\\w+)", replacement: "$1$2")! == "acbd/"
"http://ac/bd/".gsub("http://(\\w+)/(\\w+)/", replacement: "$1$2")! == "acbd"

```