"""
Write your code there
Visit localhost:4040 to see the running job
"""
#SAMPLE SPARK JOB
from pyspark.sql import SparkSession
import time

spark = SparkSession.builder \
    .appName("DockerClusterTest") \
    .getOrCreate()

sc = spark.sparkContext
def heavy_computation(x):
    time.sleep(5)
    return (x, "processed")

data = range(1, 50)

#Parallelize the task
rdd = sc.parallelize(data, numSlices=3)
parallel_result = rdd.map(heavy_computation)
results = parallel_result.collect()

print(results)

input() #Stop the UI at driver port
spark.stop()
