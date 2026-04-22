cd examples/anodapter

#class_name="missing_fasteners"
class_name=$1

adapter_path="/workspace/code/anodapter/checkpoint/${class_name}/"
path_to_checkpoint="/workspace/code/anodapter/checkpoint/${class_name}/checkpoint-$2/"
path_to_the_save_dir="/workspace/save_dir/$3"
type_name=$class_name
path_to_generated_prompt_mapping="/workspace/code/examples/anodapter/${class_name}_prompt_mapping"

CUDA_VISIBLE_DEVICES=1 python sample_anodapter.py --size 512 --num 1000 --step 100 --batch 8 --model_path $adapter_path --save_dir $path_to_the_save_dir --object_path /workspace/code/object_mask/$class_name --prompt_txt_path $path_to_generated_prompt_mapping.txt --adapter_path $adapter_path --anomaly_type $type_name
