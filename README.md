# [WIP] Math SVG image Maker

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
docker build -t nwtgck/math-to-image ./docker
```