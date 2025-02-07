#!/bin/bash
#SBATCH -J cmt0_gene
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --partition=NV100q
#SBATCH -w node08
#SBATCH --gres=gpu:1
#SBATCH --output /export/home/zonglin001/Out/twitter_bart_comet_subset0_bs16_Seed106_gene.out


# --generator_model_type bart-base; gpt2-lmhead \
python -u ./comet-case-based-train-updating-retriever-twoEmbedder-DPR-faster-May-TST.py \
        --do_train --train_batch_size 16 --dev_batch_size 16 \
        --do_test --test_batch_size 16 \
        --smooth_score 0.0 --gradient_accumulation_steps 1 --num_btch_in_bundle 600 \
        --logging_steps 150 --learning_rate 1e-5 \
        --if_froze_both_retriever \
        --generator_model_type bart-base  --retriever_model_type dpr \
        --n_doc 1 --num_cases_per_query 3 \
        --use_special_tokens_to_split_retrieved_cases --if_not_adding_special_relation_tokens --if_with_strt_mid_promp \
        --if_fast_train --if_try_one_gpu \
        --eval_per_steps 500 --patience 5 \
        --dataStore_dir /export/home/zonglin001/Checkpoints/ \
        --output_dir /export/home/zonglin001/Checkpoints/twitter_bart_comet_subset0_bs16_Seed106/  \
        --seed 106 \
        --dataset_selection 7 --subset_selection 0 \
        --if_use_nshot_data --num_sample 1  \
        --if_comet_baseline \
        # --if_randomly_mask_demonstrations --prob_randomly_mask_demonstrations 0.000 \

        # --if_only_use_retrieved_target \




## still support:
# --seed 8
# --if_only_use_relation_and_retrieved_target \
# --if_eval_analysis
# --use_only_sub_rel_for_retrieval \
# --if_use_relation_for_shakes \
# --if_only_froze_doc_retriever \


## not useful hyper-parameters
# --rand_simi_score
# --use_obj_for_retrieval
