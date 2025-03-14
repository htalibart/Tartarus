from tartarus import docking as tartarus_docking

if __name__=="__main__":
	smiles = 'CNC[C@@H](C1=CC(=C(C=C1)O)O)O'
	#smiles = 'CC(C)CC(=O)O'
	target = '4lde'
	#docking_program = 'qvina'
	docking_program = 'smina'
	score = tartarus_docking.perform_calc_single(smiles, target, docking_program)
	print(score)
