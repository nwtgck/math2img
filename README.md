# math2img - Math SVG image Maker

## Requirements

* [Crystal (Shards)](https://crystal-lang.org/)
* [Docker](https://www.docker.com/)

## Build & Run

```bash
cd <this repo>
shards build
./bin/math2img -e png sample1.math.tex
```

Then you can get `sample1.math.tex.png`


## Build a Docker image

```bash
cd <this repo>
docker build -t nwtgck/math2img ./docker
```