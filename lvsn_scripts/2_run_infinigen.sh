
### Load the dependencies for the container
module load apptainer


### To debug : 
apptainer shell -C image.sif
cd "/opt/infinigen"
source activate base
conda activate infinigen
python -m infinigen_examples.generate_indoors --seed 0 --task coarse --output_folder outputs/indoors/coarse -g fast_solve.gin singleroom.gin -p compose_indoors.terrain_enabled=False restrict_solving.restrict_parent_rooms=\[\"DiningRoom\"\]



