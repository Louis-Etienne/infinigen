
### Second script to be run on the compute node to run the infinigen code

### Setup of the env variables
export ROOT_DIR="$SCRATCH/infinigen_apptainer"
export REPO_DIR="$ROOT_DIR/infinigen"

### Load the dependencies for the container
module load apptainer

### Activate the environement
echo 'Activating the environment'
cd $REPO_DIR
# the -C option is for the container to be 'Contained'
# the --nv option is to enable the use of the GPU 
# -B $REPO_DIR:/output_dir is to bind the output directory to the container, the results will be saved in 
#                           the output_dir outside of the container in the REPO_DIR
# -W working directory of the container
apptainer shell -C --nv -B $REPO_DIR:/output_dir infinigen_latest.sif
source activate base
conda activate infinigen

### Run the wanted command
cd /opt/infinigen
# Replacing blender_gt.gin, with opengl_gt.gin will extract more ground truth with opengl
# Replacing local_256GB.gin with slurm.gin will optimize for SLURM clusters and gpu usage
# Adding cuda_terrain.gin to --pipeline_configs will enable the use of the GPU for terrain generation
python -m infinigen.datagen.manage_jobs --output_folder /output_dir/outputs/my_datasets --num_scenes 1 --pipeline_configs local_64GB.gin cuda_terrain.gin monocular.gin opengl_gt.gin indoor_background_configs.gin --configs singleroom.gin --pipeline_overrides get_cmd.driver_script='infinigen_examples.generate_indoors' manage_datagen_jobs.num_concurrent=2 LocalScheduleHandler.use_gpu=True --overrides compose_indoors.restrict_single_supported_roomtype=True 




##################################
### Possible commands ! 
##################################
#
## For simple diningroom :
# python -m infinigen_examples.generate_indoors --seed 0 --task coarse --output_folder outputs/indoors/coarse -g singleroom.gin -p compose_indoors.terrain_enabled=False restrict_solving.restrict_parent_rooms=\[\"DiningRoom\"\]
#
## For single scene in one command : 
# python -m infinigen.datagen.manage_jobs --output_folder outputs/my_dataset --num_scenes 1 --pipeline_configs local_256GB.gin monocular.gin blender_gt.gin indoor_background_configs.gin --configs singleroom.gin --pipeline_overrides get_cmd.driver_script='infinigen_examples.generate_indoors' manage_datagen_jobs.num_concurrent=16 --overrides compose_indoors.restrict_single_supported_roomtype=True 
#
# For large dataset :
# python -m infinigen.datagen.manage_jobs --output_folder outputs/my_dataset --num_scenes 1000 --pipeline_configs local_256GB.gin monocular.gin blender_gt.gin indoor_background_configs.gin --configs singleroom.gin --pipeline_overrides get_cmd.driver_script='infinigen_examples.generate_indoors' manage_datagen_jobs.num_concurrent=16 --overrides compose_indoors.restrict_single_supported_roomtype=True



