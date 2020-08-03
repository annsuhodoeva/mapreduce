SOURCE_BASE_PATH="$HOME"
echo $SOURCE_BASE_PATH

hdfs dfs -rm -r /input
hdfs dfs -rm -r /input2
hdfs dfs -rm -r /input1
hdfs dfs -rm -r /input3
hdfs dfs -rm -r /output1
hdfs dfs -rm -r /output2
hdfs dfs -rm -r /output3

HADOOP_STREAMING_PATH="/usr/lib/hadoop-mapreduce/hadoop-streaming.jar"

INPUT_DIR="/input1"
OUTPUT_DIR="/output1"

hdfs dfs -mkdir -p $INPUT_DIR
hdfs dfs -copyFromLocal $SOURCE_BASE_PATH/ratings.txt $INPUT_DIR

echo [part_1]

chmod 0777 $SOURCE_BASE_PATH/mapper.py
chmod 0777 $SOURCE_BASE_PATH/reducer.py

hadoop_streaming_arguments="\
	-file $SOURCE_BASE_PATH/mapper.py -mapper mapper.py \
	-file $SOURCE_BASE_PATH/reducer.py -reducer reducer.py \
	-input $INPUT_DIR/* -output $OUTPUT_DIR \
	"

hadoop jar $HADOOP_STREAMING_PATH $hadoop_streaming_arguments

hdfs dfs -copyToLocal $OUTPUT_DIR $SOURCE_BASE_PATH/part1

