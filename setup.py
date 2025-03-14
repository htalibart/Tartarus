from setuptools import setup

setup(
	name='tartarus',
	version='1.0',
	packages=['tartarus'],
	include_package_data=True,
	package_data={'tartarus':['data/*', 'docking_structures/*', 'docking_structures/*/*']}
)
