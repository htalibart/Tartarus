import pathlib, os, sys
import pandas as pd

import torch

from chembed import checkpoint_utils
from chembed.downstream import optimizer as chembed_optimizer

from tartarus import tadf

def fitness_st_value(smiles):
	st, osc, combined = tadf.get_properties(smiles)
	return st

def check_fitness_ok():
	print("performing fitness check...")
	smiles = 'O=CN(C=O)C1=NN2C=CC=C2N1'
	st, osc, combined = tadf.get_properties(smiles)
	print("check", smiles, "st=", st)
	assert(st!=-10000)
	print("fitness ok")


if __name__=="__main__":
	check_fitness_ok()
