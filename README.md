### 1 - Build Docker image with the basic packages (spark + pyspark)

```sh
docker build -t jupyter-spark .
```

### 2 - Run Jupyter


```sh
./run.sh
```

To access: http://localhost:8888/

Note: To access `simple-dataset.csv` you can use `/notebooks/simple-dataset.csv` from the notebooks.

