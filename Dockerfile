# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# The workflow contains only unknown_registry custom nodes without aux_id, so they could not be automatically resolved or installed:
# - ModelSamplingAuraFlow (unknown_registry, no aux_id)
# - CLIPLoaderGGUF (unknown_registry, no aux_id)
# - UnetLoaderGGUF (unknown_registry, no aux_id)
# - InpaintModelConditioning (unknown_registry, no aux_id)
# - LoadImageMask (unknown_registry, no aux_id)
# If you can provide GitHub repos for any of these (aux_id like owner/repo), add commands like:
# RUN git clone https://github.com/<owner>/<repo> /comfyui/custom_nodes/<repo>

# download models into comfyui
RUN comfy model download --url https://huggingface.co/unsloth/Qwen3-4B-GGUF/blob/main/Qwen3-4B-UD-Q6_K_XL.gguf --relative-path models/checkpoints --filename Qwen3-4B-UD-Q6_K_XL.gguf
RUN comfy model download --url https://huggingface.co/jayn7/Z-Image-Turbo-GGUF/blob/main/z_image_turbo-Q8_0.gguf --relative-path models/diffusion_models --filename z_image_turbo-Q8_0.gguf
RUN comfy model download --url https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/ae.safetensors --relative-path models/vae --filename ae.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
