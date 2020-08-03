#!/usr/bin/python3
SOURCE_BASE_PATH="$HOME"
echo $SOURCE_BASE_PATH

hdfs dfs -rm -r /input
hdfs dfs -rm -r /input2
hdfs dfs -rm -r /input1
hdfs dfs -rm -r /input3
hdfs dfs -rm -r /output
hdfs dfs -rm -r /output2
hdfs dfs -rm -r /output3


rm -r $SOURCE_BASE_PATH/part3

HADOOP_STREAMING_PATH="/usr/lib/hadoop-mapreduce/hadoop-streaming.jar"

INPUT_DIR="/input3"
OUTPUT_DIR="/output3"

hdfs dfs -mkdir -p $INPUT_DIR
hdfs dfs -copyFromLocal $SOURCE_BASE_PATH/ratings.txt $INPUT_DIR

echo [part_3]

chmod 0777 $SOURCE_BASE_PATH/mapper3.py
chmod 0777 $SOURCE_BASE_PATH/reducer3.py

hadoop_streaming_arguments="\
    -file $SOURCE_BASE_PATH/mapper3.py -mapper mapper3.py \
    -file $SOURCE_BASE_PATH/reducer3.py -reducer reducer3.py  \
    -file $SOURCE_BASE_PATH/sim.txt\
    -file $SOURCE_BASE_PATH/movies.txt\
    -input $INPUT_DIR/* -output $OUTPUT_DIR \
    "

hadoop jar $HADOOP_STREAMING_PATH $hadoop_streaming_arguments

hdfs dfs -copyToLocal $OUTPUT_DIR $SOURCE_BASE_PATH/part3


hdfs dfs -rm -r /input
hdfs dfs -rm -r /input2
hdfs dfs -rm -r /input1
hdfs dfs -rm -r /input3
hdfs dfs -rm -r /output
hdfs dfs -rm -r /output2
hdfs dfs -rm -r /output3


