chef-backup
===========

Simple backup scripts to do daily backups of an open source chef server (and to do disaster recovery on a new chef server)

Usage
=====

	chef-daily-backup BACKUP_DIR RETENTION_DAYS

Example
=======

	chef-daily-backup /chef-backups 10

Creates backups of the database, uploaded cookbooks, and basic .pem files (webui.pem and validation.pem) that can be used to restore your chef environment on a newly built chef server. The backups are stored in /chef-backups (which must already exist). Any backups in /chef-backups older than 10 days will be deleted after the current backup finishes.

Notes
=====

Currently this only works for chef 10.x, which uses couchdb to store data.