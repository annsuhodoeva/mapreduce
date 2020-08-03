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

INPUT_DIR="/input2"
OUTPUT_DIR="/output2"

hdfs dfs -mkdir -p $INPUT_DIR
hdfs dfs -copyFromLocal $SOURCE_BASE_PATH/part1/* $INPUT_DIR

echo [part_2]

chmod 0777 $SOURCE_BASE_PATH/mapper2.py
chmod 0777 $SOURCE_BASE_PATH/reducer2.py

hadoop_streaming_arguments="\
	-file $SOURCE_BASE_PATH/mapper2.py -mapper mapper2.py \
	-file $SOURCE_BASE_PATH/reducer2.py -reducer reducer2.py \
	-input $INPUT_DIR/* -output $OUTPUT_DIR \
	"

hadoop jar $HADOOP_STREAMING_PATH $hadoop_streaming_arguments

hdfs dfs -copyToLocal $OUTPUT_DIR $SOURCE_BASE_PATH/part2

hdfs dfs -rm -r $INPUT_DIR
hdfs dfs -rm -r $OUTPUT_DIR