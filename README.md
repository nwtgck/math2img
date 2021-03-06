# math2img - Convert LaTeX Math to image [![Build Status](https://travis-ci.org/nwtgck/math2img.svg?branch=master)](https://travis-ci.org/nwtgck/math2img)

## Requirements

* [Docker](https://www.docker.com/)

## Installation

```bash
brew install nwtgck/homebrew-math2img/math2img
```


## Usage


```bash
math2img -e png sample1.math.tex
```
Then you can get `sample1.math.tex.png`

### `sample1.math.tex`

```tex
\[
    e^{i\pi}+1=0
\]
```
=>

<img src="demos/demo1.svg" width="200">

## Build Requirements

* [Crystal (Shards)](https://crystal-lang.org/)


## Build & Run

```bash
git clone <this repo url>
cd <this repo>
shards build
./bin/math2img -e png samples/sample1.math.tex
```

Then you can get `sample1.math.tex.png`

(`./bin/math2img` is a generated binary file.)


## Build a Docker image

```bash
cd <this repo>
docker build -t nwtgck/math2img ./docker
```

## Gallery

<img src="demos/sample2.math.tex.svg" height="50"><br>

<img src="demos/sample3.math.tex.svg" height="50"><br>

<img src="demos/sample4.math.tex.svg" height="50"><br>

<img src="demos/sample5.math.tex.svg" height="50"><br>

<img src="demos/sample6.math.tex.svg" height="50"><br>

<img src="demos/sample7.math.tex.svg" height="50"><br>


