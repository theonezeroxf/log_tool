#!/bin/bash

# 检查是否提供了日志目录参数
if [ "$#" -ne 1 ]; then
    echo "用法: $0 <log-directory>"
    exit 1
fi

LOG_DIR=$1
ARCHIVE_DIR="./archived_logs"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_FILE="logs_archive_${TIMESTAMP}.tar.gz"
LOG_FILE="archive_log.txt"
RETENTION_DAYS=30  # 保留日志的天数

# 检查日志目录是否存在
if [ ! -d "$LOG_DIR" ]; then
    echo "错误: 提供的日志目录不存在: $LOG_DIR"
    exit 1
fi

# 创建存档目录（如果不存在）
mkdir -p "$ARCHIVE_DIR"

# 压缩日志并存储到存档目录
# 压缩最近 30 天内的日志并存储到存档目录
find "$LOG_DIR" -type f -mtime -$RETENTION_DAYS -print0 | tar --null -czf "${ARCHIVE_DIR}/${ARCHIVE_FILE}" --files-from -
# tar -czf "${ARCHIVE_DIR}/${ARCHIVE_FILE}" -C "$LOG_DIR" .
echo "tar -czf "${ARCHIVE_DIR}/${ARCHIVE_FILE}" -C "$LOG_DIR" ."

# 记录存档操作的日期和时间
echo "[$(date +"%Y-%m-%d %H:%M:%S")] 存档文件: ${ARCHIVE_DIR}/${ARCHIVE_FILE}" >> "$LOG_FILE"

# 删除时间较久的日志文件
find "$LOG_DIR" -type f -mtime +$RETENTION_DAYS -exec rm -f {} \;

echo "日志已成功存档到: ${ARCHIVE_DIR}/${ARCHIVE_FILE}"