#!/usr/bin/env bash
now=$(date +"%Y%m%d_%H%M%S")
EXP_DIR=./sfnets/bdd/pspnet_r50
mkdir -p ${EXP_DIR}
python -m torch.distributed.launch --nproc_per_node=8 train.py \
  --dataset bdd \
  --cv 0 \
  --arch network.pspnet.PSPNet_v1_r50 \
  --class_uniform_pct 0.0 \
  --class_uniform_tile 1024 \
  --lr 0.01 \
  --lr_schedule poly \
  --poly_exp 1.0 \
  --repoly 1.5  \
  --rescale 1.0 \
  --syncbn \
  --sgd \
  --ohem \
  --crop_size 832 \
  --scale_min 0.5 \
  --scale_max 2.0 \
  --color_aug 0.25 \
  --gblur \
  --max_epoch 160 \
  --wt_bound 1.0 \
  --bs_mult 2 \
  --apex \
  --exp bdd \
  --ckpt ${EXP_DIR}/ \
  --tb_path ${EXP_DIR}/ \
