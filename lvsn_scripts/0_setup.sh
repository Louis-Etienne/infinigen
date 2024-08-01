

module load StdEnv/2023
module load blender/4.0.2
module load cmake llvm glew glfw
module load python/3.10
module load opencv
module load eigen

python -m venv venv
source venv/bin/activate
pip install setuptools --upgrade
pip install -e ".[dev,terrain,vis]"