chef-backup
===========

Simple backup scripts to do daily backups of an open source chef server (and to do disaster recovery on a new chef server)

Usage
=====

Perform a daily backup (add to your crontab):
	chef-daily-backup BACKUP_DIR RETENTION_DAYS

Restore a daily backup:
	chef-restore-from-backup BACKUP_DIR BACKUP_DATE(YYYY-MM-DD)

Examples
========

	chef-daily-backup /chef-backups 10

Creates backups of the database, uploaded cookbooks, and basic .pem files (webui.pem and validation.pem) that can be used to restore your chef environment on a newly built chef server. The backups are stored in /chef-backups (which must already exist). Any backups in /chef-backups older than 10 days will be deleted after the current backup finishes.

	chef-restore-from-backup /chef-backups 2013-03-19

A warning is displayed asking if you really want to overwrite the current data on your chef server. If you choose to continue, /chef-backups will be checked to see if it contains all the necessary backups (created via chef-daily-backup). If everything's good, the script continues to tear down the existing chef environment, expand the backup for March 19th, 2013, and restart chef services.

Notes
=====

Currently this only works for chef 10.x, which uses couchdb to store data.

The restore script makes some assumptions about your setup (location of various directories, existance of the chef-webui user). Most of these can be found in constants at the top of the file. Please review before use.

Systems
=======

These scripts were written for Ubuntu systems. Patches and/or pull requests for compatibility with other systems are more than welcome.

License
=======

MIT. See [LICENSE](LICENSE)