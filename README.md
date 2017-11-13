# math2img - Convert LaTeX Math to image

## Requirements

* [Docker](https://www.docker.com/)

## Installation

```bash
brew tap nwtgck/math2img
brew install math2img
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
./bin/math2img -e png sample1.math.tex
```

Then you can get `sample1.math.tex.png`

(`./bin/math2img` is a generated binary file.)


## Build a Docker image

```bash
cd <this repo>
docker build -t nwtgck/math2img ./docker
```