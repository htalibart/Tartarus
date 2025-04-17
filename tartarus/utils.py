from contextlib import contextmanager, redirect_stderr, redirect_stdout
from os import devnull

import subprocess
from subprocess import DEVNULL, Popen, PIPE

@contextmanager
def suppress_output(verbose):
	"""Suppress output when """
	if verbose:
		pass
	else:
		with open(devnull, 'w') as fnull:
			with redirect_stderr(fnull) as err, redirect_stdout(fnull) as out:
				yield (err, out)

#def run_command(command, verbose):
#	if verbose:
#		subprocess.run(command, shell=True)
#	else:
#		subprocess.run(command, shell=True, stdout=DEVNULL, stderr=DEVNULL)
#


def run_command(command, verbose):
	p = Popen(command, stdout=PIPE, stderr=PIPE, shell=True)
	output, error = p.communicate()
	if verbose:
		print(output.decode())
	if p.returncode != 0:
		print(error.decode())
		raise RuntimeError("error when executing {}".format(command))
