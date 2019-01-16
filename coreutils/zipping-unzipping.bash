#! /usr/bin/env bash

# Zipping / unzipping
# Create an archive
#	c	create archive
#	v	verbose
#	f	file name
#	--> NO COMPRESSION!	Add filter option with compoiression algorithm
#			z	gzip		<.tar.gz extension>
#			j	bzip2		<tar.bz2 extension>
tar cvf archive_name.tar dirname/

# Extracting (untar) an archive
#	x 	extract
tar xvf archive_name.tar

# Listing an archive (View the tar archive file content without extracting)
# 	t	list (--list tuts auch)
tar tvf file_name.tar