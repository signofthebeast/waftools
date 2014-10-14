#!/usr/bin/env python
# -*- encoding: utf-8 -*-
# Michel Mooij, michel.mooij7@gmail.com


'''
Description
-----------
Prepares a package release, performs following steps:
- build source distribution (i.e. runs 'python setup.py sdist ...')
- build HTML version of package documentation (using Sphinx)
- create zip containing documentation
'''


import shutil
import waftools
from waflib import Scripting


top = '.'
out = 'build'


VERSION = waftools.version
APPNAME = 'waftools'


def options(opt):
	pass


def configure(conf):
	conf.check_waf_version(mini='1.7.0')


def build(bld):
	if bld.cmd == 'build':
		bld.cmd_and_log('python setup.py sdist --formats=gztar --dist-dir=.', cwd=bld.path.abspath())
	if bld.cmd == 'clean':
		node = bld.path.find_node('dist')
		if node:
			shutil.rmtree(node.abspath())

	bld.recurse('doc')
	bld.add_post_fun(post)


def post(ctx):
	tg = ctx.get_tgen_by_name('doc')
	ctx = Scripting.Dist()
	ctx.algo = 'zip'
	ctx.arch_name = 'waftools-doc-html.zip'
	html = tg.path.get_bld().find_node('html')
	ctx.files = html.ant_glob('**')
	ctx.base_name = ''
	ctx.base_path = html
	ctx.archive()


def dist(dst):
	dst.algo = 'tar.gz'
	dst.excl = '**/*~ **/*.pyc **/__pycache__/** \
		**/.lock-waf_* build/** **/*.tar.gz \
		MANIFEST dist/** doc/_build/** \
		.git/** **/.gitignore \
		**/.settings/** **/.project **/.pydevproject \
		test/**/.cproject test/**/*.launch test/**/Debug/** \
		test/output/** test/build/** \
		test/**/Makefile test/**/*.mk \
		test/**/CMakeLists.txt \
		test/**/*.cbp test/**/*.layout test/**/*.workspace test/**/*.workspace.layout \
		test/**/*.vcproj test/**/*.sln test/**/*.user test/**/*.ncb test/**/*.suo'


