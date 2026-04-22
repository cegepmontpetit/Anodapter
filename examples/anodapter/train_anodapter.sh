dataset_name=$1

available_categories=(
    $2
)

echo "${2} -> vfx" > ${2}_prompt_mapping.txt

# 카테고리별 anomaly type은 내부 구조에서 자동 처리됨
# prompt는 JSON 파일로 전달
PROMPT_JSON_PATH="/workspace/code/prompt_list.json"

# 시작 포트 번호
START_PORT=29501

# 사용할 GPU
GPU_LIST="1"

# 현재 .sh 위치 기준으로 .py 파일 절대경로 계산
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_FILE="${SCRIPT_DIR}/train_anodapter.py"

# 루프 실행
for index in "${!available_categories[@]}"
do
    category=${available_categories[$index]}
    PORT=$((START_PORT + index))

    echo "▶ Starting training for category: $category (port: $PORT)"

    OUTPUT_DIR="/workspace/code/anodapter/checkpoint/$category"

    CUDA_VISIBLE_DEVICES=$GPU_LIST accelerate launch --main_process_port=$PORT "$SCRIPT_FILE" \
        --pretrained_model_name_or_path=CompVis/stable-diffusion-v1-4 \
        --train_text_encoder \
        --train_t2iadapter \
        --num_normal_limit=8 \
        --instance_data_dir=/workspace/datasets/${dataset_name}/captures_drone_tiled \
        --object_data_dir=/workspace/datasets/${dataset_name}/captures_drone_tiled/${category}/Object_mask \
        --prompt_json_path=$PROMPT_JSON_PATH \
        --output_dir=$OUTPUT_DIR \
        --instance_prompt="a photo of dqd" \
        --mask_prompt="a photo of sks" \
        --resolution=512 \
        --train_batch_size=1 \
        --gradient_accumulation_steps=1 \
        --learning_rate=5e-6 \
        --lr_scheduler="constant" \
        --lr_warmup_steps=0 \
        --checkpointing_steps=10000 \
        --max_train_steps=40000 
        #--generate_object_mask 

    echo "✅ Finished training for category: $category"
done
