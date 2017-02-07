# Long Press

<a href="url"><img src="https://raw.githubusercontent.com/davebrny/long-press/master/long%20press.ico"></a>

&nbsp;


**Type symbols without having to use the shift key:**

`long press =` &nbsp; `--->` &nbsp; `+`

`long press /` &nbsp; `--->` &nbsp; `?`



**Type [unicode](https://en.wikipedia.org/wiki/List_of_Unicode_characters) characters:**  

`long press a` &nbsp; `--->` &nbsp; `á`

`long press b` &nbsp; `--->` &nbsp; `•`

`long press y` &nbsp; `--->` &nbsp; `✔`



**Paste longer strings of text:**

`long press e` &nbsp; `--->` &nbsp; `your.email@site.com`

```
long press t  --->

Yours Sincerely
your_name
```


&nbsp;


## Usage


When you first run the script the active key list will be [example.ini](https://github.com/davebrny/long-press/blob/master/example.ini). You can use that file or create a new ini key list as long as it's kept in the same folder.

> (You can download my key list [here](https://gist.github.com/davebrny/ec0b107973cce88217ed14d6183e52ab) and use that as a starting point either)

The section name has to be called `[long press]` and you will need to change the value of `active_list` in [settings.ini](https://github.com/davebrny/long-press/blob/master/settings.ini) to match the name of the new ini file that you want to use.  



&nbsp;


```autohotkey
[ini format example]
ini key     = ini value             ; comments are allowed here

/           = {?}                   ; send an alternate key
b           = {U+2022}              ; send unicode
e           = your@email.com        ; send a string
```  

Any comments that are at the end of the line will be stripped out when the script runs.   
There is also no need to use the escape character if the ini key name is `[` or `;`

If there are duplicate keys then the last one in the list is the one that will be used:

```
f           = F
f           = {U+261B}
```

To temporarily disable the long press action for a key, put a semi-colon at the start of the ini value. Leaving the ini value blank will have the same effect.

```
8           = ; {*}
8           =
```

&nbsp;

### Long press duration

The default duration to trigger a long press is between 240 and 500 milliseconds. If you end up triggering long presses without meaning to then try increasing the `press_duration` in the settings file to 260 or 280 until you find a time that suits. If the key is held down for longer the 500 it will start to spammmmmmmm as normal, but that time may also need to be adjusted depending what system or hardware you're using.

&nbsp;


**Some notes:**

The keys that work best with long pressing are keys that send a character such as `a-z`, `0-9` or any of the symbol keys. Keys like `escape`, `pgUp` or `pause` wont work that well (or at all) unless they are used in conjunction with some other commands. (See the commands.ahk file for an example of how `backspace` and `delete` are used)

`long press backspace` &nbsp; `--->` &nbsp; delete the whole word instead of just one character

`long press enter` &nbsp; `--->` &nbsp; make a new line before the current line instead of after it

Some hotkeys like ctrl + f can be sent but not all will work either so some trial and error might be needed.

`long press f` &nbsp; `--->` &nbsp; send ctrl + f
