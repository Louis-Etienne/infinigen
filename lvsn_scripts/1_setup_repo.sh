
### First script to be run on the login node to download the necessary components
echo 'Setting up the repository'
echo 'This should be done on the login node'

### Setup of the env variables
export ROOT_DIR="$SCRATCH/infinigen_apptainer"
export REPO_DIR="$ROOT_DIR/infinigen"

### Download the infinigen submodules
echo 'Downloading the infinigen submodules'
cd $REPO_DIR
git submodule update --init --recursive

### Load the dependencies for the container
echo 'Loading the dependencies for the container'
module load apptainer

### Download the image containing the environement necessary to run infinigen
echo 'Downloading the image containing the environment necessary to run infinigen'
cd $REPO_DIR
apptainer pull --arch amd64 library://lemes3/compute_canada_infinigen/infinigen:latest
