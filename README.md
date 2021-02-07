<p align="center"><img src="https://user-images.githubusercontent.com/1377253/93661464-edf77780-fa4f-11ea-9622-86cf7e34d460.png" height="80" /></p>

<h1 align="center">Project Soul Taker</h1>
---

*This game requires [Nodejs](https://nodejs.org/en/) (v6 or higher) to be installed to run most of the commands below.*

### 1. Download

You can also create a new project based on this template using [degit](https://github.com/Rich-Harris/degit) which will ignore all .git related files.
```sh
npx degit KinoCreatesGames/soul-taker my-flixel-game
cd my-flixel-game
```

### 2. Install dependencies

```sh
npm i 
```

### 3. Build
It's recommended to run the [Haxe compilation server](https://youtu.be/3crCJlVXy-8) when developing to cache the compilation, this should be done in a separate terminal window/tab with the following command.
```sh
npm run comp-server
```

Your **.hx** files are watched with [Facebook's watman plugin](https://facebook.github.io/watchman/). Anytime you save a file it will trigger an automatic rebuild. 
```sh
npm start 
```
