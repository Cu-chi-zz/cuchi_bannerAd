# cuchi_bannerAd
FiveM in-game advertising banner

+ Only with natives
+ Fully optimised (server-side: **0.01ms** / **0.02ms** *while working* | client-side: **0.00ms** / **0.01ms** *while working*)
+ Customizable
+ Easy to use with other scripts by triggering events

---
# How to use it
| events names           | Top of screen ? | Banner color                                | Text (max. 100 characters) | Text color                                  | Display duration (in seconds) |
|------------------------|-----------------|---------------------------------------------|----------------------------|---------------------------------------------|-------------------------------|
| "cadBanner:callServer" | boolean         | { int red, int green, int blue, int alpha } | string                     | { int red, int green, int blue, int alpha } | integer                       |
> Example:</br>

**TriggerServerEvent("cadBanner:callServer", true, {10, 10, 10, 255}, "TESTING AD BANNER :)", {255, 255, 255, 255}, 2)**</br>
*will display "TESTING AD BANNER :)" while 2 seconds on a dark background with a white foreground color on the top of the user's screen.*
![image](https://user-images.githubusercontent.com/42467470/133144593-78b4188f-10c7-467b-8eb1-92e4b3cc93bc.png)


🎉 waiting for suggestions or contributions!
> Download [here](https://github.com/Cu-chi/cuchi_adBanner/releases/download/1.1.0/cuchi_bannerAd.zip)   
> Preview [here](https://youtu.be/0QV2Mq8FBYM)
