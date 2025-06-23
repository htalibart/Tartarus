from tartarus import docking as tartarus_docking

if __name__=="__main__":
	#smiles = 'CNC[C@@H](C1=CC(=C(C=C1)O)O)O'
	smiles = 'ClC1(c2ccccc2)C(=O)NC(=O)NC1=O'
	target = '1syh'
	#docking_program = 'qvina'
	docking_program = 'smina'
	score = tartarus_docking.perform_calc_single(smiles, target, docking_program, filter_molecules=False)
	print(score)
